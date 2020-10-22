Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E092960AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900669AbgJVOIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900662AbgJVOIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:08:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE86C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 07:08:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z2so1810251ilh.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qyB9VGcnwRmV7uWQxOItmIqBY22BS8lzGEFNJoBC4fs=;
        b=2B+nN1yWXOA54E7/hBm7W9SYoldYFseQrJHvdXwS41REnvpYiPVk9brmmk1XUdpqDK
         O8XIOiiucGc8TycgCWRZVpOIJ0s5blu8/7Dl9S+x87uUdCEB6HYfi1avPRtDNrryQC/i
         rw4Fxw++/9fgFynWmNNt46Td1omSCPVjfV1r0ilqU4crUK+EdfL40XmgH6y3SDQSHtKu
         DwkVyciFPAJVW+RkFZYZbpvn1aC7nSApyeakpKqvjDuXO13pcVic2nSJmeBqgvfDSuB1
         BB4d9UrNmbw4KWa8mL01xNEcK3iEyxNAQk+/w9Z/zb3QWpRmYcuZgVSPmMF8mE2diT5w
         E4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qyB9VGcnwRmV7uWQxOItmIqBY22BS8lzGEFNJoBC4fs=;
        b=j9Yi9oDDAvpWM3C7ZGxI10UTvkn9iRteGE37HaNUedjtkE/CSl/txWZH/iCvva0Hls
         5MaLLAag+xcPJIBlZsEoIYudYPQl4CCMomStWOQYu1p5H2vXcSplKvl7BOal/HwV556N
         xozSf97/YBb/5+LTjAM4LMp498GRBXVm8ij0xOpvXNgwBvapcK7qvnbafSHT2CoUOAFi
         pC/ozOtPnPJrMXY8TloZZNmCG2C6TOVQgenvxUXSESQGdFqFPPlQ5ucPFLfUhHn95h0/
         ZAmjTd6M0Du6nEdgGKgC4U8L5M/GkpPDt62XmnJZ1fXgGLOznt5JM9IC55yv/7+F5XRn
         1bAg==
X-Gm-Message-State: AOAM530sCLovNw1yN5B7k9C9yOU7HE7zGOIG5BhtvvDnuU4ec8L1V6EK
        xniRFoqIJFYuA1lFOChcShavYJKbgKiXsw==
X-Google-Smtp-Source: ABdhPJyUzut/930LmZRIerniuf18HLXCdmG+LHK2wxfJtRs+DGdaFwPAudgE6vofbFxH9MO/SsCTbA==
X-Received: by 2002:a92:c784:: with SMTP id c4mr1863552ilk.157.1603375690293;
        Thu, 22 Oct 2020 07:08:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e17sm1225926ile.60.2020.10.22.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 07:08:09 -0700 (PDT)
Subject: Re: Question on io-wq
To:     "Zhang,Qiang" <qiang.zhang@windriver.com>
Cc:     viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <98c41fba-87fe-b08d-2c8c-da404f91ef31@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8dd4bc4c-9d8e-fb5a-6931-3e861ad9b4bf@kernel.dk>
Date:   Thu, 22 Oct 2020 08:08:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98c41fba-87fe-b08d-2c8c-da404f91ef31@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/20 3:02 AM, Zhang,Qiang wrote:
> 
> Hi Jens Axboe
> 
> There are some problem in 'io_wqe_worker' thread, when the 
> 'io_wqe_worker' be create and  Setting the affinity of CPUs in NUMA 
> nodes, due to CPU hotplug, When the last CPU going down, the 
> 'io_wqe_worker' thread will run anywhere. when the CPU in the node goes 
> online again, we should restore their cpu bindings?

Something like the below should help in ensuring affinities are
always correct - trigger an affinity set for an online CPU event. We
should not need to do it for offlining. Can you test it?


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 4012ff541b7b..3bf029d1170e 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -19,6 +19,7 @@
 #include <linux/task_work.h>
 #include <linux/blk-cgroup.h>
 #include <linux/audit.h>
+#include <linux/cpu.h>
 
 #include "io-wq.h"
 
@@ -123,9 +124,13 @@ struct io_wq {
 	refcount_t refs;
 	struct completion done;
 
+	struct hlist_node cpuhp_node;
+
 	refcount_t use_refs;
 };
 
+static enum cpuhp_state io_wq_online;
+
 static bool io_worker_get(struct io_worker *worker)
 {
 	return refcount_inc_not_zero(&worker->ref);
@@ -1096,6 +1101,13 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	ret = cpuhp_state_add_instance_nocalls(io_wq_online, &wq->cpuhp_node);
+	if (ret) {
+		kfree(wq->wqes);
+		kfree(wq);
+		return ERR_PTR(ret);
+	}
+
 	wq->free_work = data->free_work;
 	wq->do_work = data->do_work;
 
@@ -1145,6 +1157,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	ret = PTR_ERR(wq->manager);
 	complete(&wq->done);
 err:
+	cpuhp_state_remove_instance_nocalls(io_wq_online, &wq->cpuhp_node);
 	for_each_node(node)
 		kfree(wq->wqes[node]);
 	kfree(wq->wqes);
@@ -1164,6 +1177,8 @@ static void __io_wq_destroy(struct io_wq *wq)
 {
 	int node;
 
+	cpuhp_state_remove_instance_nocalls(io_wq_online, &wq->cpuhp_node);
+
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
 	if (wq->manager)
 		kthread_stop(wq->manager);
@@ -1191,3 +1206,40 @@ struct task_struct *io_wq_get_task(struct io_wq *wq)
 {
 	return wq->manager;
 }
+
+static bool io_wq_worker_affinity(struct io_worker *worker, void *data)
+{
+	struct task_struct *task = worker->task;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	do_set_cpus_allowed(task, cpumask_of_node(worker->wqe->node));
+	task->flags |= PF_NO_SETAFFINITY;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	return false;
+}
+
+static int io_wq_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct io_wq *wq = hlist_entry_safe(node, struct io_wq, cpuhp_node);
+	int i;
+
+	rcu_read_lock();
+	for_each_node(i)
+		io_wq_for_each_worker(wq->wqes[i], io_wq_worker_affinity, NULL);
+	rcu_read_unlock();
+	return 0;
+}
+
+static __init int io_wq_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "io-wq/online",
+					io_wq_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
+	io_wq_online = ret;
+	return 0;
+}
+subsys_initcall(io_wq_init);

-- 
Jens Axboe

