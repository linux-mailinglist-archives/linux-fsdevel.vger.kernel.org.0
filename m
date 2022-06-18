Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24355056C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 16:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbiFROJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiFROIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 10:08:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D317A8E
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 07:08:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so2888667pjr.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=XbVFDWoGMjB7BQRSkULxQAI98FA/9YBNynz4n5L/nZw=;
        b=7zNujocLE0E+/rwoirwcLkYYsCM9RshilDFVk0N90L6cgE1T2lDmsNtspod3te9mhr
         uVYU/peSEwa8c2dLqV+b6dbhkdQmqvuB0NU7K5bHSWsTkuLs/mi9J2jaCk2SzvTLNWTv
         v35fxu4/mFjebUCTyBp2sAJgLrsSAUipJM7LV43zzp0KxSi7tDjAcPRHDP0EmvU+VQgv
         AdCkg6PPlBtYnVWWeXWGiKJL7AKEeF9eTv6sJ4DlJ/Huf0sT8xedJz279FT1zDvyrZnj
         kdGa0akG70CbkG4KA2ch6l6V1Fmrp5svYbvTDibrNKlsUBUDaD/9C2N5qBCaIraJwgNq
         2vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=XbVFDWoGMjB7BQRSkULxQAI98FA/9YBNynz4n5L/nZw=;
        b=rcIV53Yv+cmVMbYM1k2/3qNhXkFjpx33QrtJFNDM6K7Ujv/n8f290mTR3MJL3hjNGb
         NT/ak0jWm0scEXUcr3YKuIFIsHeitQEY26MuIWTG5oZfckZNjBYBC9xw3IGzc9qpw+cz
         qEjIsn5YWLJYsmbViSlkN9tV8DFIkrUi84pYo1BJlM5dmsdfkDNTzblPieAX3IsATi0J
         wFXzTVPsOQ1BoafyU8ATYoxmp6+EgyNNKHE+OdNgWbQD1l+Z8J/WCA0HoOmwxM7Q9JtS
         xpdf0Z+33G+AKCmTnhd8nOKOKrDEQDjj0X/hwJ1qgMqGGsMx8KyqF84h7Z1wIUtCWIqs
         zRhQ==
X-Gm-Message-State: AJIora/RSHDSMBxBVNjKgLivaF0C3mpSU3HDfg4+q/xItg0LiTU2VGNj
        b1AzDl6kFYKqIxKxO/iYfOtSA3spxFcLRQ==
X-Google-Smtp-Source: AGRyM1tsWVqmbVKr2IfnEu0Jx3FwAet0GJ43WxJFa30IyJOIrXgJrYjfXlx+tmtpgRlw/8juHg6bKA==
X-Received: by 2002:a17:90a:31cf:b0:1c9:f9b8:68c7 with SMTP id j15-20020a17090a31cf00b001c9f9b868c7mr27489974pjf.34.1655561290154;
        Sat, 18 Jun 2022 07:08:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00163f2fe1e64sm5407485plg.255.2022.06.18.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 07:08:09 -0700 (PDT)
Message-ID: <b3e19eb1-18c4-8599-b68d-bf28673237d1@kernel.dk>
Date:   Sat, 18 Jun 2022 08:08:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] iov_iter: import single segments iovecs as ITER_UBUF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using an ITER_UBUF is more efficient than an ITER_IOV, and for the single
segment case, there's no reason to use an ITER_IOV when an ITER_UBUF will
do. Experimental data collected shows that ~2/3rds of iovec imports are
single segments, from applications using readv/writev or recvmsg/sendmsg
that are iovec based.

Explicitly check for nr_segs == 1 and import those as ubuf rather than
iovec based iterators.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Lightly tested - boots and works just fine, and I ran this through the
liburing test suite which does plenty of single segment readv/writev
as well.

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6b2bf6f6f374..0973c622d3c0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1813,6 +1813,21 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		return PTR_ERR(iov);
 	}
 
+	/*
+	 * Fast path - single segment import. Use UBUF for these, rather
+	 * than setup an ITER_IOV.
+	 */
+	if (nr_segs == 1) {
+		ssize_t ret;
+
+		total_len = iovp[0]->iov_len;
+		ret = import_ubuf(type, iovp[0]->iov_base, total_len, i);
+		*iovp = NULL;
+		if (unlikely(ret < 0))
+			return ret;
+		return total_len;
+	}
+
 	/*
 	 * According to the Single Unix Specification we should return EINVAL if
 	 * an element length is < 0 when cast to ssize_t or if the total length

-- 
Jens Axboe

