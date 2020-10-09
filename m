Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49876288A60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbgJIOKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732907AbgJIOK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:10:28 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904EC0613D2;
        Fri,  9 Oct 2020 07:10:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r4so2554787ioh.0;
        Fri, 09 Oct 2020 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3QOGsB4kmNOkLnadomVzhGM8EBck9+Fm/DaJrjH2f+c=;
        b=WR1XJ695yDX4OIgU1SUP1UEsQbi/4XD5tVbrM8yzQbP7xoUhQjJJuNd/5sCsmJn3DH
         Phn0ucyqPNr7m+XzLZm7HHVHYRV/l4PartVpguC9RPLekeaFYWw1yLsJ3zskr6PlURWj
         KxqcDHAiTfrlq/BZ4nNlR4fGGPNrMGWLXFAPwuHMnZDkG+4WxoxXhsEhRX2mB9mKPG22
         NChnZ5y3XTHg3jhX7DxfmsrueK2cT8SwosNzdasRu4TEZIFmUQw72GMrUiXkxiMF9QG+
         nYtKJA43rSegS+M0nws6P06peAQBSRbx6U95pNqa+BzTE6MLdqamvYkMidEClosgpmFj
         c3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3QOGsB4kmNOkLnadomVzhGM8EBck9+Fm/DaJrjH2f+c=;
        b=ZGxVElsC0eFWA2o1IHJZSbr7N+FA/gsiWU2jQOFERjbRThUCifPho2258IQ6B7IcAL
         TcfCqaUTkMMK8SkVZNORKcD//eA3lrchCYNrVR/wu+OUfbTAx00sUR5GKZvSeMzj1f1P
         /xo/3R6FD4EvXiD7j/m3Fm5i7iyJKdDA7xqHY+Tws57P2cXmq+gnww1ld+acFd4Kk6a5
         7sYiCnRu5ciLUt5q2CB+0OF2i3nq+RZ22cwFKPO6OHzkZhjJH1nm/0pw7yasnC8EeQaA
         bM07wOgmp6hc0GNK2Vq3zN3CwiAQJXlbwRaiT2OSMdJIBGqZ0EZA9SGa83l5jpfMPDSL
         sniA==
X-Gm-Message-State: AOAM531X/373Iw4DoAQeAO+6K1dXFnmgEQ//MhMuNYZKrYzRL8MlSfUA
        uFkpC3Vl4bF7toWYtSpxYdGiUKsowa8eSW9nVmSauOsGtXuOIw==
X-Google-Smtp-Source: ABdhPJwODwUhP1uVzkGnFxnKlagh6KIIs7M9LNa4SYPI5aYa19oHJyxD5dDRi5DW2dGMId7MEa3UOZ7faYPE/Fl7P+M=
X-Received: by 2002:a02:2a49:: with SMTP id w70mr11180574jaw.132.1602252627889;
 Fri, 09 Oct 2020 07:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
In-Reply-To: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 16:10:15 +0200
Message-ID: <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
Subject: Re: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b9f53905b13d82a6"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b9f53905b13d82a6
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 9, 2020 at 3:49 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi Ted,
>
> with <ext4.git#dev> up to commit
> ab7b179af3f98772f2433ddc4ace6b7924a4e862 ("Merge branch
> 'hs/fast-commit-v9' into dev") I see some warnings (were reported via
> kernel-test-bot)...
>
> fs/jbd2/recovery.c:241:15: warning: unused variable 'seq' [-Wunused-variable]
> fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
> fs/ext4/fast_commit.c:1091:6: warning: variable 'start_time' is used
> uninitialized whenever '||' condition is true
> [-Wsometimes-uninitialized]
>
> ...and more severe a build breakage with CONFIG_JBD2=and CONFIG_EXT4_FS=m
>
> ERROR: modpost: "jbd2_fc_release_bufs" [fs/ext4/ext4.ko] undefined!
> ERROR: modpost: "jbd2_fc_init" [fs/ext4/ext4.ko] undefined!
> ERROR: modpost: "jbd2_fc_stop_do_commit" [fs/ext4/ext4.ko] undefined!
> ERROR: modpost: "jbd2_fc_stop" [fs/ext4/ext4.ko] undefined!
> ERROR: modpost: "jbd2_fc_start" [fs/ext4/ext4.ko] undefined!
>
> Looks like missing exports.
>

This fixes it...

$ git diff
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 8a51c1ad7088..e50aeefaa217 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -754,6 +754,7 @@ int jbd2_fc_start(journal_t *journal, tid_t tid)

       return 0;
}
+EXPORT_SYMBOL(jbd2_fc_start);

/*
 * Stop a fast commit. If fallback is set, this function starts commit of
@@ -778,11 +779,13 @@ int jbd2_fc_stop(journal_t *journal)
{
       return __jbd2_fc_stop(journal, 0, 0);
}
+EXPORT_SYMBOL(jbd2_fc_stop);

int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid)
{
       return __jbd2_fc_stop(journal, tid, 1);
}
+EXPORT_SYMBOL(jbd2_fc_stop_do_commit);

/* Return 1 when transaction with given tid has already committed. */
int jbd2_transaction_committed(journal_t *journal, tid_t tid)
@@ -954,6 +957,7 @@ int jbd2_fc_release_bufs(journal_t *journal)

       return 0;
}
+EXPORT_SYMBOL(jbd2_fc_release_bufs);

/*
 * Conversion of logical to physical block numbers for the journal
@@ -1389,6 +1393,7 @@ int jbd2_fc_init(journal_t *journal, int num_fc_blks)
               return -ENOMEM;
       return 0;
}
+EXPORT_SYMBOL(jbd2_fc_init);

/* jbd2_journal_init_dev and jbd2_journal_init_inode:
 *

- Sedat -

--000000000000b9f53905b13d82a6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="jbd2-journal-fix-build-when-CONFIG_EXT4-as-module.diff"
Content-Disposition: attachment; 
	filename="jbd2-journal-fix-build-when-CONFIG_EXT4-as-module.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kg2bu3b30>
X-Attachment-Id: f_kg2bu3b30

ZGlmZiAtLWdpdCBhL2ZzL2piZDIvam91cm5hbC5jIGIvZnMvamJkMi9qb3VybmFsLmMKaW5kZXgg
OGE1MWMxYWQ3MDg4Li5lNTBhZWVmYWEyMTcgMTAwNjQ0Ci0tLSBhL2ZzL2piZDIvam91cm5hbC5j
CisrKyBiL2ZzL2piZDIvam91cm5hbC5jCkBAIC03NTQsNiArNzU0LDcgQEAgaW50IGpiZDJfZmNf
c3RhcnQoam91cm5hbF90ICpqb3VybmFsLCB0aWRfdCB0aWQpCiAKIAlyZXR1cm4gMDsKIH0KK0VY
UE9SVF9TWU1CT0woamJkMl9mY19zdGFydCk7CiAKIC8qCiAgKiBTdG9wIGEgZmFzdCBjb21taXQu
IElmIGZhbGxiYWNrIGlzIHNldCwgdGhpcyBmdW5jdGlvbiBzdGFydHMgY29tbWl0IG9mCkBAIC03
NzgsMTEgKzc3OSwxMyBAQCBpbnQgamJkMl9mY19zdG9wKGpvdXJuYWxfdCAqam91cm5hbCkKIHsK
IAlyZXR1cm4gX19qYmQyX2ZjX3N0b3Aoam91cm5hbCwgMCwgMCk7CiB9CitFWFBPUlRfU1lNQk9M
KGpiZDJfZmNfc3RvcCk7CiAKIGludCBqYmQyX2ZjX3N0b3BfZG9fY29tbWl0KGpvdXJuYWxfdCAq
am91cm5hbCwgdGlkX3QgdGlkKQogewogCXJldHVybiBfX2piZDJfZmNfc3RvcChqb3VybmFsLCB0
aWQsIDEpOwogfQorRVhQT1JUX1NZTUJPTChqYmQyX2ZjX3N0b3BfZG9fY29tbWl0KTsKIAogLyog
UmV0dXJuIDEgd2hlbiB0cmFuc2FjdGlvbiB3aXRoIGdpdmVuIHRpZCBoYXMgYWxyZWFkeSBjb21t
aXR0ZWQuICovCiBpbnQgamJkMl90cmFuc2FjdGlvbl9jb21taXR0ZWQoam91cm5hbF90ICpqb3Vy
bmFsLCB0aWRfdCB0aWQpCkBAIC05NTQsNiArOTU3LDcgQEAgaW50IGpiZDJfZmNfcmVsZWFzZV9i
dWZzKGpvdXJuYWxfdCAqam91cm5hbCkKIAogCXJldHVybiAwOwogfQorRVhQT1JUX1NZTUJPTChq
YmQyX2ZjX3JlbGVhc2VfYnVmcyk7CiAKIC8qCiAgKiBDb252ZXJzaW9uIG9mIGxvZ2ljYWwgdG8g
cGh5c2ljYWwgYmxvY2sgbnVtYmVycyBmb3IgdGhlIGpvdXJuYWwKQEAgLTEzODksNiArMTM5Myw3
IEBAIGludCBqYmQyX2ZjX2luaXQoam91cm5hbF90ICpqb3VybmFsLCBpbnQgbnVtX2ZjX2Jsa3Mp
CiAJCXJldHVybiAtRU5PTUVNOwogCXJldHVybiAwOwogfQorRVhQT1JUX1NZTUJPTChqYmQyX2Zj
X2luaXQpOwogCiAvKiBqYmQyX2pvdXJuYWxfaW5pdF9kZXYgYW5kIGpiZDJfam91cm5hbF9pbml0
X2lub2RlOgogICoK
--000000000000b9f53905b13d82a6--
