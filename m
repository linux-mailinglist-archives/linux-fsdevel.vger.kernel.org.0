Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828CB4048CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhIILB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhIILBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:01:25 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225DC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 04:00:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l10so1443353ilh.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6whkAs0FNhSaWkTgSco4dNsVDlvQSW3F00cJNaFNaZs=;
        b=J+qRozR3E0qFUP+bpnk1QFM3Pny70kdJ+nLejfd8yE9eQgPJeRCH7SkjRNUetUW9EK
         XnWlONj+lqNfmONpZiJu1eNllnbfQOBRxnwlw/8I/6lA5Sv4B1LlgfAh40F2N/oVjkRW
         NNYZsC1FJ/Sjz69oeM37soMXEmw124YHIlehV/XfyW0PnOdryGBu/ZlPFefFE/L0RZKO
         L7fPkGsOoz9Lb+FBUd4C1xhT/4Yhp8gYJuxvjo8FgNclUlhoIe03h0/UP2NgqjJRl67v
         whOkrmOHPQYaiZn0hZglAgzNAssVmmFRgnKdhrxoZr2A5j+QB7nA5wNeq5Ah9k0t5+MH
         p9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6whkAs0FNhSaWkTgSco4dNsVDlvQSW3F00cJNaFNaZs=;
        b=CCvnfuD05D3bYzNECVfi8Ps5zzPyK0a3qLq2xuUAPObhzzjWATXBwwlPARyb2ffn1M
         2wDj3AjyCbn8Fm3V2vvjlCkdEj/1jo6MWS9ybgrxjqfZwPpcv+pRArwm9fPbur27c4ST
         ApBbpreKPfJCGSgwG4Lwk/Z1Drcpk2TvrrtvYMRp4BAnVHw2wHTgfvT1GTIi1v5rFFKd
         TJNL/frPUOrGChI+eryGFroX+rsIKu99BPl25l9QvDi++b6sVDdMoCh2Zetec9gnbseT
         3B09ATGL1wQix1yRbTIBO6qoWCO5E8Na2f2EWOCDKFMbpXIwRFrPpEGUPFfPc+rQHTgU
         p/0Q==
X-Gm-Message-State: AOAM53274uIUPmVbwNHI577rEzpkXs0lUaCknUGUtFiX/bR+83oXJ/VY
        /tZx04d+8fbC6OLBPPT1KsJptspdt+WtTkaDiYYv+5pi
X-Google-Smtp-Source: ABdhPJzln+WVcwL7m9dCDMvvmvI92enz7M0CujstYg7cYVYgcsfB287bin16DtmzTQKKOlCpEWmtmx3Doo4vOipKOXM=
X-Received: by 2002:a05:6e02:198d:: with SMTP id g13mr1858305ilf.319.1631185215947;
 Thu, 09 Sep 2021 04:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com>
In-Reply-To: <20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Sep 2021 14:00:04 +0300
Message-ID: <CAOQ4uxhnnG6g29NomN_MLvfk9Cf6gEfaOkW0RuXDCNREhmofdw@mail.gmail.com>
Subject: Re: [regression] fsnotify fails stress test since fsnotify_for_v5.15-rc1
 merged
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Petr Vorel <pvorel@suse.cz>
Content-Type: multipart/mixed; boundary="0000000000005c2c4f05cb8de783"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000005c2c4f05cb8de783
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 9:33 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Hi,
>
> Since this commit:
>
> commit ec44610fe2b86daef70f3f53f47d2a2542d7094f
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Tue Aug 10 18:12:19 2021 +0300
>
>     fsnotify: count all objects with attached connectors
>
>
>
>
> Kernel fsnotify can't finish a stress testcase that used to pass quickly.
>
> Kernel hung at umount. Can not be killed but restarting the server.
>
> Reproducer text is attached.
>

Hi Murphy,

Thank you for the detailed report.
I was able to reproduce the hang and the attached patch fixes it for me.
Cloud you please verify the fix yourself as well?

This is a good regression test.
Did you consider contributing it to LTP?
I think the LTP team could also help converting your reproducer to
an LTP test (CC: Petr).

Thanks,
Amir.

--0000000000005c2c4f05cb8de783
Content-Type: text/x-patch; charset="US-ASCII"; name="fsnotify-fix-sb_connectors-leak.patch"
Content-Disposition: attachment; 
	filename="fsnotify-fix-sb_connectors-leak.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ktcteqms0>
X-Attachment-Id: f_ktcteqms0

RnJvbSAxNGQzYzMxMzA2MmRmYmM4NmIzZDJjNGQ3ZGVlYzU2YTA5NjQzMmY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDkgU2VwIDIwMjEgMTM6NDY6MzQgKzAzMDAKU3ViamVjdDogW1BBVENIXSBmc25v
dGlmeTogZml4IHNiX2Nvbm5lY3RvcnMgbGVhawoKRml4IGEgbGVhayBpbiBzX2Zzbm90aWZ5X2Nv
bm5lY3RvcnMgY291bnRlciBpbiBjYXNlIG9mIGEgcmFjZSBiZXR3ZWVuCmNvbmN1cnJlbnQgYWRk
IG9mIG5ldyBmc25vdGlmeSBtYXJrIHRvIGFuIG9iamVjdC4KClRoZSB0YXNrIHRoYXQgbG9zdCB0
aGUgcmFjZSBmYWlscyB0byBkcm9wIHRoZSBjb3VudGVyIGJlZm9yZSBmcmVlaW5nCnRoZSB1bnVz
ZWQgY29ubmVjdG9yLgoKRml4ZXM6IGVjNDQ2MTBmZTJiOCAoImZzbm90aWZ5OiBjb3VudCBhbGwg
b2JqZWN0cyB3aXRoIGF0dGFjaGVkIGNvbm5lY3RvcnMiKQpSZXBvcnRlZC1ieTogTXVycGh5IFpo
b3UgPGplbmNjZS5rZXJuZWxAZ21haWwuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1mc2RldmVsLzIwMjEwOTA3MDYzMzM4LnljYXc2d3ZoenJmc2ZkbHBAeHpob3V4LnVz
ZXJzeXMucmVkaGF0LmNvbS8KU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4KLS0tCiBmcy9ub3RpZnkvbWFyay5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9mcy9ub3RpZnkvbWFyay5jIGIvZnMvbm90aWZ5
L21hcmsuYwppbmRleCA5NTAwNmQxZDI5YWIuLmZhMWQ5OTEwMWY4OSAxMDA2NDQKLS0tIGEvZnMv
bm90aWZ5L21hcmsuYworKysgYi9mcy9ub3RpZnkvbWFyay5jCkBAIC01MzEsNiArNTMxLDcgQEAg
c3RhdGljIGludCBmc25vdGlmeV9hdHRhY2hfY29ubmVjdG9yX3RvX29iamVjdChmc25vdGlmeV9j
b25ucF90ICpjb25ucCwKIAkJLyogU29tZW9uZSBlbHNlIGNyZWF0ZWQgbGlzdCBzdHJ1Y3R1cmUg
Zm9yIHVzICovCiAJCWlmIChpbm9kZSkKIAkJCWZzbm90aWZ5X3B1dF9pbm9kZV9yZWYoaW5vZGUp
OworCQlmc25vdGlmeV9wdXRfc2JfY29ubmVjdG9ycyhjb25uKTsKIAkJa21lbV9jYWNoZV9mcmVl
KGZzbm90aWZ5X21hcmtfY29ubmVjdG9yX2NhY2hlcCwgY29ubik7CiAJfQogCi0tIAoyLjI1LjEK
Cg==
--0000000000005c2c4f05cb8de783--
