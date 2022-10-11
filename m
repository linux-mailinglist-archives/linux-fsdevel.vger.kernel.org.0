Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFB5FB46B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJKOS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKOSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:18:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42989412D
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 07:18:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h13so12204168pfr.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XH/WqrOOWftebuMfO8W8ORiHpePN+5NyHaR4jE1y7VU=;
        b=yXBoCt/mc+NIDIRQje2hh07SUKdRiu1f8sddxrAOHKP0wUL3GFM/N22c3sdLC0gJiL
         B0fYU7xtdkQCtOR3n+Te4F1BHYtOU1bRagZ18ngWEQWXjCydrmpg0Wjocfk7zCJW72Hk
         LQDDQ7utQoQYKi0D3wVlkYucCK01VQhNM/sSNQjsD+esd0K0zKPeyIgkMYTl0YJWumF8
         AVKdKXZ4vJyJDJpMvOx/Mwp82bIlRq3BCR573c3qrvyTxeVCMU5Hz3oVeAQdezmmMuvQ
         4Oa38VwOiAwdmFmHZxFJqPWBmeI+1pcY1EA1NBmzAmqRCFvXlUnQfS+YlurJqbeszgl/
         wTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XH/WqrOOWftebuMfO8W8ORiHpePN+5NyHaR4jE1y7VU=;
        b=3rQDrtwYmn4DolISj+wHnrpuCQXFbq3b2jkBtBMdaOvlyujcyn9p6/VXU9pi6xWTwt
         +ReeEiw6j8S1jrY8JxUjkTcAmffAc/XV+cYRswV3ey+FQwpK8Vgi/bq4+ZHTxiKFRVwQ
         FP9hkylQHeWJaxwf6h+Ybdy9hSkvLPUGMVX1YQDZUFqaynuxXO9xYZRlX8S/tUIpzujW
         00cnxGHKuWUDcbRP8NYc9nrDxFkESXRPoMHHgA0Ne5LwRXlYFkILQtrck+L2NfiCiHzh
         lSRr13tAoQ7Yad6JxQblZ7bepe+d5Yrb3rBiAadWNHxpqD+IfDG7FOOMXnwp1zx7MddD
         9GGg==
X-Gm-Message-State: ACrzQf1FkKTX510UFLOgHmCgEsewoFMCEzY0JvXeAgHSIACjkLuVl0Da
        MOcWE6m3jxNaF9JoBeeq7aYge5w7bKjMp11s
X-Google-Smtp-Source: AMsMyM7fnaTgPUqxD6OJ4hrPoNwOCYdXpcx+R1WXOhgW7AzK1/zmbFqj4JsyQcP5sDRPDELZ65MHEw==
X-Received: by 2002:a05:6a00:114f:b0:563:a934:718e with SMTP id b15-20020a056a00114f00b00563a934718emr4487060pfm.41.1665497903122;
        Tue, 11 Oct 2022 07:18:23 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm8713593plg.205.2022.10.11.07.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:18:22 -0700 (PDT)
Message-ID: <1941f3d3-5b7a-7b87-cc53-382cac1647d6@kernel.dk>
Date:   Tue, 11 Oct 2022 08:18:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [regression, v6.0-rc0, io-uring?] filesystem freeze hangs on
 sb_wait_write()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Dave Chinner <david@fromorbit.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <20221010050319.GC2703033@dread.disaster.area>
 <20221011004025.GE2703033@dread.disaster.area>
 <8e45c8ee-fe38-75a9-04f4-cfa2d54baf88@gmail.com>
 <697611c3-04b0-e8ea-d43d-d05b7c334814@kernel.dk>
 <db66c011-4b86-1167-f1e0-9308c7e6eb71@gmail.com>
 <fbec411b-afd9-8b3b-ee2d-99a36f50a01b@kernel.dk>
In-Reply-To: <fbec411b-afd9-8b3b-ee2d-99a36f50a01b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/10/22 8:54 PM, Jens Axboe wrote:
> On 10/10/22 8:10 PM, Pavel Begunkov wrote:
>> On 10/11/22 03:01, Jens Axboe wrote:
>>> On 10/10/22 7:10 PM, Pavel Begunkov wrote:
>>>> On 10/11/22 01:40, Dave Chinner wrote:
>>>> [...]
>>>>> I note that there are changes to the the io_uring IO path and write
>>>>> IO end accounting in the io_uring stack that was merged, and there
>>>>> was no doubt about the success/failure of the reproducer at each
>>>>> step. Hence I think the bisect is good, and the problem is someone
>>>>> in the io-uring changes.
>>>>>
>>>>> Jens, over to you.
>>>>>
>>>>> The reproducer - generic/068 - is 100% reliable here, io_uring is
>>>>> being exercised by fsstress in the background whilst the filesystem
>>>>> is being frozen and thawed repeatedly. Some path in the io-uring
>>>>> code has an unbalanced sb_start_write()/sb_end_write() pair by the
>>>>> look of it....
>>>>
>>>> A quick guess, it's probably
>>>>
>>>> b000145e99078 ("io_uring/rw: defer fsnotify calls to task context")
>>>>
>>>> ?From a quick look, it removes? kiocb_end_write() -> sb_end_write()
>>>> from kiocb_done(), which is a kind of buffered rw completion path.
>>>
>>> Yeah, I'll take a look.
>>> Didn't get the original email, only Pavel's reply?
>>
>> Forwarded.
> 
> Looks like the email did get delivered, it just ended up in the
> fsdevel inbox.

Nope, it was marked as spam by gmail...

>> Not tested, but should be sth like below. Apart of obvious cases
>> like __io_complete_rw_common() we should also keep in mind
>> when we don't complete the request but ask for reissue with
>> REQ_F_REISSUE, that's for the first hunk
> 
> Can we move this into a helper?

Something like this? Not super happy with it, but...


diff --git a/io_uring/rw.c b/io_uring/rw.c
index 453e0ae92160..1c8d00f9af9f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -234,11 +234,32 @@ static void kiocb_end_write(struct io_kiocb *req)
 	}
 }
 
+/*
+ * Trigger the notifications after having done some IO, and finish the write
+ * accounting, if any.
+ */
+static void io_req_io_end(struct io_kiocb *req)
+{
+	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
+
+	if (rw->kiocb.ki_flags & IOCB_WRITE) {
+		kiocb_end_write(req);
+		fsnotify_modify(req->file);
+	} else {
+		fsnotify_access(req->file);
+	}
+}
+
 static bool __io_complete_rw_common(struct io_kiocb *req, long res)
 {
 	if (unlikely(res != req->cqe.res)) {
 		if ((res == -EAGAIN || res == -EOPNOTSUPP) &&
 		    io_rw_should_reissue(req)) {
+			/*
+			 * Reissue will start accounting again, finish the
+			 * current cycle.
+			 */
+			io_req_io_end(req);
 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
 			return true;
 		}
@@ -264,15 +285,7 @@ static inline int io_fixup_rw_res(struct io_kiocb *req, long res)
 
 static void io_req_rw_complete(struct io_kiocb *req, bool *locked)
 {
-	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
-
-	if (rw->kiocb.ki_flags & IOCB_WRITE) {
-		kiocb_end_write(req);
-		fsnotify_modify(req->file);
-	} else {
-		fsnotify_access(req->file);
-	}
-
+	io_req_io_end(req);
 	io_req_task_complete(req, locked);
 }
 
@@ -317,6 +330,7 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 		req->file->f_pos = rw->kiocb.ki_pos;
 	if (ret >= 0 && (rw->kiocb.ki_complete == io_complete_rw)) {
 		if (!__io_complete_rw_common(req, ret)) {
+			io_req_io_end(req);
 			io_req_set_res(req, final_ret,
 				       io_put_kbuf(req, issue_flags));
 			return IOU_OK;

-- 
Jens Axboe
