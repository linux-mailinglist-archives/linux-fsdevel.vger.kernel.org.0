Return-Path: <linux-fsdevel+bounces-76635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEWcH6o/hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:23:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09368102ACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0928A3144E37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3F42B72D;
	Fri,  6 Feb 2026 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="krzW3a93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC2429821
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405190; cv=none; b=dv3q4bdEzX70Y7pFIifanYh1FvJxUmEBy13ycfO94wY2jngmwyuq6i89Ladx+hQgTTPChcoLD742xD8mcQMlWqs0iLNVinpvDC4/OxevBxYzNmbQoxRJItOu3qumOdn47I3Cr2LaDTFoGftRzi9F2T1Jtm/jk4/j5m0C2+43tFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405190; c=relaxed/simple;
	bh=h9Tf2g6p95uHGjNW/hGwPXe+6bpAWGHAV9ausLLvgVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KE8AMfL9vDTINt1UCr0sl444njdHYG43jNlPPCJuMagTroE8XVAG0X3Xpwcr3CE44tt/bqJxG93IaISMrdGIommSO/5DhZTdn2867FwQk+SPki4X93r+c65kXI5A+vhBUG3Uwp5JZ15cKGzkUddIYN0lC3fYmPsd6KaW4ormDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=krzW3a93; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64455a2a096so2255107d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770405189; x=1771009989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl58u+sFBQ4YmsvUDIxZwjfmqlOJxFYb10cvJ3X1hxk=;
        b=krzW3a93bA4TERNeBEvT0Eq8aUwXLNd2FYaUicXq0ldRYWgAw2VKc+XFjTUBuA+k6D
         TcjZ2vNFYYwhvhueF3jowrJzO2Ol0ZYU2MtlzaAM62Um53WNhY82j2jlSPxBnQSmFW4Y
         ytRltH2A9kmE5d0FcFwD2QgEoiMparpNNzM0V0BbP2rLYBS6VX45E6YcQ6499SvF7QaG
         jwKfDi1lgM9kWsn0fQaF7iACLd+tagLu3pkDrq7JmKfsDAFMJWFTGTpqoM68e9H2o8bN
         91RaxDJ0JuqHklmLQLJQheDon3hUIz8LzBsfPyCZ50NEd+VwpHWlZgzBn9USD4/Jm7sY
         KzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405189; x=1771009989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kl58u+sFBQ4YmsvUDIxZwjfmqlOJxFYb10cvJ3X1hxk=;
        b=Ex6xFb+yFWEoQi5EwGX90lKbwkigEZemCEmjk7OkIX1iNS35uvsaeigI/zov0bifxS
         E6F2hAatmotHm/vP8dAz2dx34fWuPFFYyvYxMcUu7N7OMLPwYGw/8yn8L/+lgKdMxyz5
         T3VkJieNTdvCvBpZCndF+iwjr+X5LsTsmp96HjacezEAOCiY4Hwy5ENVjcaTrm/f8E6E
         kH5MpGrTcflMF6yjjsUqJnbrM1M7MWBrD/lDY/pU5hsVBUxt99uqio2XO5A1YCbpmf+N
         KtJAwdGSLCgCm4ZSAD9XGVipkHUZsoDTSdvO76jtEzwIJJWIpMKWLWrpNk97x3pIPrHW
         gAYg==
X-Gm-Message-State: AOJu0Yzg1FOQId3oOtSeQyX60zINpmhzNVdOXUTmRDp5HoHe7udAyOLC
	KLrLoOC1itzIhwP6SyzYbD275LdEuk+eEMAZGViHT+jQ8iRMB7NJu4H7c9i/UZAKvHBc/W2W8Ea
	+qpimpYs=
X-Gm-Gg: AZuq6aJiSQZZ1nSm+IGirAdKUHbJD9ZNMG1CKAkJnd/LmI9YTEA21HZ4XyEAVhtdyMa
	Ob0+6sKemoCpi4zJ5M4n4iHYYQwZ7vNXeL2giAfAIJNKlgYGp0NNE6TZ0eT/4hyvFOnB1TKuUkL
	sSuj7sBrAfRWhBQFaXmVHcTnqmeyHGcYaBSnyNdC0YOcf6b6dZ6rWYjIXCogcFjFFL1B+3xiYQL
	8oUAC7Xn60HlJiK9OluIuw3nu8SstNM6znzcQyzB37q+ZkEj3rRfiIVk0Rn7gMapGBmsSwqgxYL
	gkOj3RxtqhLubyqllLjllXwP44OaRIGbFuu6/IVxnJ6A1SucVGrGQcrZcPjrFObqo0Zmb9ghxr+
	FAGbS4yXXdCCSN/1S6r35h6zsYnGlU88NoI3hce3wtRAXcy82S3JGy/7vNNvm7NBP+TnLOlbNyW
	Y6gsOt1B8MtCsXwigvo1pPlogwz9Uehsbxs3+56KkTJ7hHZnF1D3prY6JhEbiaJnf1w+oaXj5Q6
	QZs/d31k7DfpY2MfRQU7HQ=
X-Received: by 2002:a81:b813:0:b0:795:294c:fd3d with SMTP id 00721157ae682-7952ab55894mr57194667b3.50.1770405189073;
        Fri, 06 Feb 2026 11:13:09 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9fc0:ed7d:72bd:ecd1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28697fsm29051277b3.50.2026.02.06.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:13:08 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/4] ml-lib: Introduce Machine Learning (ML) library declarations
Date: Fri,  6 Feb 2026 11:11:33 -0800
Message-Id: <20260206191136.2609767-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206191136.2609767-1-slava@dubeyko.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dubeyko.com];
	TAGGED_FROM(0.00)[bounces-76635-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko-com.20230601.gappssmtp.com:dkim,dubeyko.com:mid,dubeyko.com:email]
X-Rspamd-Queue-Id: 09368102ACC
X-Rspamd-Action: no action

Any kernel subsystem can be extended by one or several ML model(s).
ML model is represented by struct ml_lib_model that contains:
(1) ML model mode, (2) ML model state, (3) pointer on parent kernel
subsystem, (4) parent kernel subsystem state, (5) ML model options,
(6) current dataset, (7) ML model specialized operations,
(8) dataset specialized operations.

Any kernel subsystem can be in several modes that define
how this subsystem interacts with ML model in user-space:
(1) EMERGENCY_MODE - ignore ML model and run default algorithm(s),
(2) LEARNING_MODE - ML model is learning and any recommendations
requires of checking and errors back-propagation,
(3) COLLABORATION_MODE - ML model has good prediction but still
requires correction by default algorithm(s),
(4) RECOMMENDATION_MODE - ML model is capable to substitute
the default algorithm(s).

ML model can be: (1) created, (2) initialized, (3) started,
(4) running, (5) stopped, (6) shutted down.

The API of ML model includes:
(1) ml_model_create() - create ML model and initialize generic field
(2) ml_model_init() - execute specialized logic of ML model initialization
(3) ml_model_re_init() - execute specialized logic of ML model re-init
(4) ml_model_start() - start ML model activity
(5) ml_model_stop() - stop ML model activity
(6) ml_model_destroy() - destroy ML model and free all allocated memory
(7) get_system_state() - get current state of parent kernel subsystem
(8) ml_model_get_dataset() - prepare dataset for extraction by user-space agent
(9) ml_model_discard_dataset() - discard/obsolete dataset by user-space agent
(10) ml_model_preprocess_data() - preprocess data of current dataset
(11) ml_model_publish_data() - notify user-space agent about new dataset
(12) ml_model_preprocess_recommendation() - preprocess ML model recommendations
(13) estimate_system_state() - estimate parent kernel subsystem mode
(14) apply_ml_model_recommendation() - apply ML model recommendations
(15) execute_ml_model_operation() - execute logic following ML model mode
(16) estimate_ml_model_efficiency() - estimate ML model efficiency
(17) ml_model_error_backpropagation() - execute error backpropagation
(18) correct_system_state() - correct parent kernel subsystem mode

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 include/linux/ml-lib/ml_lib.h | 425 ++++++++++++++++++++++++++++++++++
 1 file changed, 425 insertions(+)
 create mode 100644 include/linux/ml-lib/ml_lib.h

diff --git a/include/linux/ml-lib/ml_lib.h b/include/linux/ml-lib/ml_lib.h
new file mode 100644
index 000000000000..001e781e0bf1
--- /dev/null
+++ b/include/linux/ml-lib/ml_lib.h
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Machine Learning (ML) library
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _LINUX_ML_LIB_H
+#define _LINUX_ML_LIB_H
+
+/*
+ * Any kernel subsystem can be in several modes
+ * that define how this subsystem interacts with
+ * ML model in user-space:
+ * (1) EMERGENCY_MODE - ignore ML model and run default algorithm(s).
+ * (2) LEARNING_MODE - ML model is learning and any recommendations
+ *                     requires of checking and errors back-propagation.
+ * (3) COLLABORATION_MODE - ML model has good prediction but still
+ *                          requires correction by default algorithm(s).
+ * (4) RECOMMENDATION_MODE - ML model is capable to substitute
+ *                           the default algorithm(s).
+ */
+enum ml_lib_system_mode {
+	ML_LIB_UNKNOWN_MODE,
+	ML_LIB_EMERGENCY_MODE,
+	ML_LIB_LEARNING_MODE,
+	ML_LIB_COLLABORATION_MODE,
+	ML_LIB_RECOMMENDATION_MODE,
+	ML_LIB_MODE_MAX
+};
+
+enum {
+	ML_LIB_UNKNOWN_MODEL_STATE,
+	ML_LIB_MODEL_CREATED,
+	ML_LIB_MODEL_INITIALIZED,
+	ML_LIB_MODEL_STARTED,
+	ML_LIB_MODEL_RUNNING,
+	ML_LIB_MODEL_STOPPED,
+	ML_LIB_MODEL_SHUTTING_DOWN,
+	ML_LIB_MODEL_STATE_MAX
+};
+
+struct ml_lib_model;
+
+#define ML_LIB_SLEEP_TIMEOUT_DEFAULT	(10)
+
+/*
+ * struct ml_lib_model_options - ML model global options
+ * @sleep_timeout: main thread's sleep timeout
+ *
+ * These options define behavior of ML model.
+ * The options can be defined during init() or re-init() call.
+ */
+struct ml_lib_model_options {
+	u32 sleep_timeout;
+};
+
+/*
+ * struct ml_lib_model_run_config - ML model run config
+ * @sleep_timeout: main thread's sleep timeout
+ *
+ * The run config is used for correction of ML model options
+ * by means of start/stop methods pair.
+ */
+struct ml_lib_model_run_config {
+	u32 sleep_timeout;
+};
+
+/*
+ * struct ml_lib_subsystem - kernel subsystem object
+ * @type: object type
+ * @size: number of bytes in allocated object
+ * @private: private data of subsystem
+ */
+struct ml_lib_subsystem {
+	atomic_t type;
+	size_t size;
+
+	void *private;
+};
+
+enum {
+	ML_LIB_UNKNOWN_SUBSYSTEM_TYPE,
+	ML_LIB_GENERIC_SUBSYSTEM,
+	ML_LIB_SPECIALIZED_SUBSYSTEM,
+	ML_LIB_SUBSYSTEM_TYPE_MAX
+};
+
+/*
+ * struct ml_lib_subsystem_state - shared kernel subsystem state
+ * @state: object state
+ * @size: number of bytes in allocated object
+ */
+struct ml_lib_subsystem_state {
+	atomic_t state;
+	size_t size;
+};
+
+enum {
+	ML_LIB_UNKNOWN_SUBSYSTEM_STATE,
+	ML_LIB_SUBSYSTEM_CREATED,
+	ML_LIB_SUBSYSTEM_INITIALIZED,
+	ML_LIB_SUBSYSTEM_STARTED,
+	ML_LIB_SUBSYSTEM_RUNNING,
+	ML_LIB_SUBSYSTEM_SHUTTING_DOWN,
+	ML_LIB_SUBSYSTEM_STOPPED,
+	ML_LIB_SUBSYSTEM_STATE_MAX
+};
+
+struct ml_lib_subsystem_state_operations {
+	void *(*allocate)(size_t size, gfp_t gfp);
+	void (*free)(struct ml_lib_subsystem_state *state);
+	int (*init)(struct ml_lib_subsystem_state *state);
+	int (*destroy)(struct ml_lib_subsystem_state *state);
+	int (*check_state)(struct ml_lib_subsystem_state *state);
+	struct ml_lib_subsystem_state *
+	    (*snapshot_state)(struct ml_lib_subsystem *object);
+	int (*estimate_system_state)(struct ml_lib_model *ml_model);
+	int (*correct_system_state)(struct ml_lib_model *ml_model);
+};
+
+/*
+ * struct ml_lib_dataset - exported subsystem's dataset
+ * @type: object type
+ * @state: object state
+ * @allocated_size: number of bytes in allocated object
+ * @portion_offset: portion offset in the data stream
+ * @portion_size: extracted portion size
+ */
+struct ml_lib_dataset {
+	atomic_t type;
+	atomic_t state;
+	size_t allocated_size;
+
+	u64 portion_offset;
+	u32 portion_size;
+};
+
+enum {
+	ML_LIB_UNKNOWN_DATASET_TYPE,
+	ML_LIB_EMPTY_DATASET,
+	ML_LIB_VALUE_DATASET,
+	ML_LIB_STRUCTURE_DATASET,
+	ML_LIB_MEMORY_STREAM_DATASET,
+	ML_LIB_DATASET_TYPE_MAX
+};
+
+enum {
+	ML_LIB_UNKNOWN_DATASET_STATE,
+	ML_LIB_DATASET_ALLOCATED,
+	ML_LIB_DATASET_CLEAN,
+	ML_LIB_DATASET_EXTRACTED_PARTIALLY,
+	ML_LIB_DATASET_EXTRACTED_COMPLETELY,
+	ML_LIB_DATASET_OBSOLETE,
+	ML_LIB_DATASET_EXTRACTION_FAILURE,
+	ML_LIB_DATASET_CORRUPTED,
+	ML_LIB_DATASET_STATE_MAX
+};
+
+struct ml_lib_dataset_operations {
+	void *(*allocate)(size_t size, gfp_t gfp);
+	void (*free)(struct ml_lib_dataset *dataset);
+	int (*init)(struct ml_lib_dataset *dataset);
+	int (*destroy)(struct ml_lib_dataset *dataset);
+	int (*extract)(struct ml_lib_model *ml_model,
+			struct ml_lib_dataset *dataset);
+	int (*preprocess_data)(struct ml_lib_model *ml_model,
+				struct ml_lib_dataset *dataset);
+	int (*publish_data)(struct ml_lib_model *ml_model,
+			    struct ml_lib_dataset *dataset);
+};
+
+/*
+ * struct ml_lib_request_config - dataset operation configuration
+ * @type: object type
+ * @state: object state
+ * @size: number of bytes in allocated object
+ */
+struct ml_lib_request_config {
+	atomic_t type;
+	atomic_t state;
+	size_t size;
+};
+
+enum {
+	ML_LIB_UNKNOWN_REQUEST_CONFIG_TYPE,
+	ML_LIB_EMPTY_REQUEST_CONFIG,
+	ML_LIB_REQUEST_CONFIG_TYPE_MAX
+};
+
+enum {
+	ML_LIB_UNKNOWN_REQUEST_CONFIG_STATE,
+	ML_LIB_REQUEST_CONFIG_ALLOCATED,
+	ML_LIB_REQUEST_CONFIG_INITIALIZED,
+	ML_LIB_REQUEST_CONFIG_STATE_MAX
+};
+
+struct ml_lib_request_config_operations {
+	void *(*allocate)(size_t size, gfp_t gfp);
+	void (*free)(struct ml_lib_request_config *config);
+	int (*init)(struct ml_lib_request_config *config);
+	int (*destroy)(struct ml_lib_request_config *config);
+};
+
+struct ml_lib_user_space_request {
+};
+
+struct ml_lib_user_space_request_operations {
+	int (*operation)(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_request *request);
+};
+
+struct ml_lib_user_space_notification {
+};
+
+struct ml_lib_user_space_notification_operations {
+	int (*operation)(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_notification *notify);
+};
+
+struct ml_lib_user_space_recommendation {
+};
+
+struct ml_lib_user_space_recommendation_operations {
+	int (*operation)(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint);
+};
+
+struct ml_lib_backpropagation_feedback {
+};
+
+struct ml_lib_backpropagation_operations {
+	int (*operation)(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint);
+};
+
+/*
+ * struct ml_lib_model_operations - ML model operations
+ * @create: specialized method of ML model creation
+ * @init: specialized method of ML model initialization
+ * @re_init: specialized method of ML model re-initialization
+ * @start: specialized method of ML model start
+ * @stop: specialized method of ML model stop
+ * @destroy: specialized method of ML model destroy
+ * @get_system_state: specialized method of getting subsystem state
+ * @get_dataset: specialized method of getting a dataset
+ * @preprocess_data: specialized method of data preprocessing
+ * @publish_data: specialized method of sharing data with user-space
+ * @preprocess_recommendation: specialized method of preprocess recomendations
+ * @estimate_system_state: specialized method of system state estimation
+ * @apply_recommendation: specialized method of recommendations applying
+ * @execute_operation: specialized method of operation execution
+ * @estimate_efficiency: specialized method of operation efficiency estimation
+ * @error_backpropagation: specialized method of error backpropagation
+ * @correct_system_state: specialized method of subsystem state correction
+ */
+struct ml_lib_model_operations {
+	int (*create)(struct ml_lib_model *ml_model);
+	int (*init)(struct ml_lib_model *ml_model,
+		    struct ml_lib_model_options *options);
+	int (*re_init)(struct ml_lib_model *ml_model,
+			struct ml_lib_model_options *options);
+	int (*start)(struct ml_lib_model *ml_model,
+		     struct ml_lib_model_run_config *config);
+	int (*stop)(struct ml_lib_model *ml_model);
+	void (*destroy)(struct ml_lib_model *ml_model);
+	struct ml_lib_subsystem_state *
+		(*get_system_state)(struct ml_lib_model *ml_model);
+	int (*get_dataset)(struct ml_lib_model *ml_model,
+			   struct ml_lib_dataset *dataset);
+	int (*preprocess_data)(struct ml_lib_model *ml_model,
+				struct ml_lib_dataset *dataset);
+	int (*publish_data)(struct ml_lib_model *ml_model,
+			    struct ml_lib_dataset *dataset,
+			    struct ml_lib_user_space_notification *notify);
+	int (*preprocess_recommendation)(struct ml_lib_model *ml_model,
+			    struct ml_lib_user_space_recommendation *hint);
+	int (*estimate_system_state)(struct ml_lib_model *ml_model);
+	int (*apply_recommendation)(struct ml_lib_model *ml_model,
+			    struct ml_lib_user_space_recommendation *hint);
+	int (*execute_operation)(struct ml_lib_model *ml_model,
+			    struct ml_lib_user_space_recommendation *hint,
+			    struct ml_lib_user_space_request *request);
+	int (*estimate_efficiency)(struct ml_lib_model *ml_model,
+			    struct ml_lib_user_space_recommendation *hint,
+			    struct ml_lib_user_space_request *request);
+	int (*error_backpropagation)(struct ml_lib_model *ml_model,
+			    struct ml_lib_backpropagation_feedback *feedback,
+			    struct ml_lib_user_space_notification *notify);
+	int (*correct_system_state)(struct ml_lib_model *ml_model);
+};
+
+/*
+ * struct ml_lib_model - ML model declaration
+ * @mode: ML model mode (enum ml_lib_system_mode)
+ * @state: ML model state
+ * @subsystem_name: name of susbsystem
+ * @model_name: name of the ML model
+ * @parent: parent kernel subsystem
+ * @parent_state: parent kernel subsystem's state
+ * @options: ML model options
+ * @model_ops: ML model specialized operations
+ * @system_state_ops: subsystem state specialized operations
+ * @dataset_ops: dataset specialized operations
+ * @request_config_ops: specialized dataset configuration operations
+ * @kobj: /sys/<subsystem>/<ml_model>/ ML model object
+ * @kobj_unregister: completion state for <ml_model> kernel object
+ */
+struct ml_lib_model {
+	atomic_t mode;
+	atomic_t state;
+	const char *subsystem_name;
+	const char *model_name;
+
+	struct ml_lib_subsystem *parent;
+
+	spinlock_t parent_state_lock;
+	struct ml_lib_subsystem_state * __rcu parent_state;
+
+	spinlock_t options_lock;
+	struct ml_lib_model_options * __rcu options;
+
+	spinlock_t dataset_lock;
+	struct ml_lib_dataset * __rcu dataset;
+
+	struct ml_lib_model_operations *model_ops;
+	struct ml_lib_subsystem_state_operations *system_state_ops;
+	struct ml_lib_dataset_operations *dataset_ops;
+	struct ml_lib_request_config_operations *request_config_ops;
+
+	/* /sys/<subsystem>/<ml_model>/ */
+	struct kobject kobj;
+	struct completion kobj_unregister;
+};
+
+/* ML library API */
+
+void *allocate_ml_model(size_t size, gfp_t gfp);
+void free_ml_model(struct ml_lib_model *ml_model);
+void *allocate_subsystem_object(size_t size, gfp_t gfp);
+void free_subsystem_object(struct ml_lib_subsystem *object);
+void *allocate_ml_model_options(size_t size, gfp_t gfp);
+void free_ml_model_options(struct ml_lib_model_options *options);
+void *allocate_subsystem_state(size_t size, gfp_t gfp);
+void free_subsystem_state(struct ml_lib_subsystem_state *state);
+void *allocate_dataset(size_t size, gfp_t gfp);
+void free_dataset(struct ml_lib_dataset *dataset);
+void *allocate_request_config(size_t size, gfp_t gfp);
+void free_request_config(struct ml_lib_request_config *config);
+
+int ml_model_create(struct ml_lib_model *ml_model,
+		    const char *subsystem_name,
+		    const char *model_name,
+		    struct kobject *subsystem_kobj);
+int ml_model_init(struct ml_lib_model *ml_model,
+		  struct ml_lib_model_options *options);
+int ml_model_re_init(struct ml_lib_model *ml_model,
+		     struct ml_lib_model_options *options);
+int ml_model_start(struct ml_lib_model *ml_model,
+		   struct ml_lib_model_run_config *config);
+int ml_model_stop(struct ml_lib_model *ml_model);
+void ml_model_destroy(struct ml_lib_model *ml_model);
+struct ml_lib_subsystem_state *get_system_state(struct ml_lib_model *ml_model);
+int ml_model_get_dataset(struct ml_lib_model *ml_model,
+			 struct ml_lib_request_config *config,
+			 struct ml_lib_user_space_request *request);
+int ml_model_discard_dataset(struct ml_lib_model *ml_model);
+int ml_model_preprocess_data(struct ml_lib_model *ml_model,
+			     struct ml_lib_dataset *dataset);
+int ml_model_publish_data(struct ml_lib_model *ml_model,
+			  struct ml_lib_dataset *dataset,
+			  struct ml_lib_user_space_notification *notify);
+int ml_model_preprocess_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint);
+int estimate_system_state(struct ml_lib_model *ml_model);
+int apply_ml_model_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint);
+int execute_ml_model_operation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request);
+int estimate_ml_model_efficiency(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request);
+int ml_model_error_backpropagation(struct ml_lib_model *ml_model,
+			    struct ml_lib_backpropagation_feedback *feedback,
+			    struct ml_lib_user_space_notification *notify);
+int correct_system_state(struct ml_lib_model *ml_model);
+
+/* Generic implementation of ML model's methods */
+
+int generic_create_ml_model(struct ml_lib_model *ml_model);
+int generic_init_ml_model(struct ml_lib_model *ml_model,
+			  struct ml_lib_model_options *options);
+int generic_re_init_ml_model(struct ml_lib_model *ml_model,
+			     struct ml_lib_model_options *options);
+int generic_start_ml_model(struct ml_lib_model *ml_model,
+			   struct ml_lib_model_run_config *config);
+int generic_stop_ml_model(struct ml_lib_model *ml_model);
+void generic_destroy_ml_model(struct ml_lib_model *ml_model);
+struct ml_lib_subsystem_state *
+generic_get_system_state(struct ml_lib_model *ml_model);
+int generic_get_dataset(struct ml_lib_model *ml_model,
+			struct ml_lib_dataset *dataset);
+int generic_preprocess_data(struct ml_lib_model *ml_model,
+			    struct ml_lib_dataset *dataset);
+int generic_publish_data(struct ml_lib_model *ml_model,
+			 struct ml_lib_dataset *dataset,
+			 struct ml_lib_user_space_notification *notify);
+int generic_preprocess_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint);
+int generic_estimate_system_state(struct ml_lib_model *ml_model);
+int generic_apply_recommendation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint);
+int generic_execute_operation(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request);
+int generic_estimate_efficiency(struct ml_lib_model *ml_model,
+			 struct ml_lib_user_space_recommendation *hint,
+			 struct ml_lib_user_space_request *request);
+int generic_error_backpropagation(struct ml_lib_model *ml_model,
+			    struct ml_lib_backpropagation_feedback *feedback,
+			    struct ml_lib_user_space_notification *notify);
+int generic_correct_system_state(struct ml_lib_model *ml_model);
+
+#endif /* _LINUX_ML_LIB_H */
-- 
2.34.1


