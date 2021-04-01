Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FF35179C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhDARm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhDARkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:07 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D1C00F7EA
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 08:09:17 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id j15so532931vkc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7FkbOKrISnl5eo0V6tNuhbk/bjz60IoSavdhFOF5WE=;
        b=kPtwVjAPcS9y2E/9xbM1Twx/Eh8M6P6XyLCNga8D421GK2v+zLZZqfr99RWG6ZufrM
         YPOKIigp/AljXiIFB63WlR6sbgbIxXnMjrwtngmtXMwGUNImQFec2ljSu1kXiR1lKBfC
         DhPinJzQmb2le04eyuQASxIUDjAzfyTOx9ZHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7FkbOKrISnl5eo0V6tNuhbk/bjz60IoSavdhFOF5WE=;
        b=SnaoGwkZMXx2yMn5NyR64JIs0oczfgY17whl3yjopke45o/fqJM8j2TyOnozb1ik0I
         36h7bOF4zEA0lv+VF4ZkUjwZi7ScjD5vw8+PkF+YOQh619RV7vvFcTGYqjdo7lbcNKlj
         2Cq510nw3Y1yliDrHkM/V+/tDzFkkcTis/9bIwhVYHxuKNyECmUp1x6HzwevfBwQkDjA
         0r9b3rQAeevU2csg89lNcr2kQHCkMBh8TM5qhMvqRdzkoH76UVAWRZTxGFbSLVdLLNlu
         ZYOEy9N/AokSGedJYd9ktMKkgbga81ovR4MzqD79ETOA6W0xOPVrs/QNO5GjHMQCcXdH
         zOwA==
X-Gm-Message-State: AOAM532hdgRVzXnZCPazi+BQ/zdZfJ+AbbkslWZLjWhmULNMOtGvobLQ
        Ol4PXUv4mS7zVI7niJ2bhvMidrXYLa5YOi94GWSqzg==
X-Google-Smtp-Source: ABdhPJxGfXRManZuqkotDfGlxOpQnGT8y0MUu0jkkUbvjhVksUkz8LWpfTxIHd8ZJaxYmoCNUhq3nRC0mDMCRei6mqc=
X-Received: by 2002:a1f:a047:: with SMTP id j68mr5693082vke.14.1617289756362;
 Thu, 01 Apr 2021 08:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtUOVF-_GWk8Z-zUHUss0=GAd7HOY_qPSNroUx9og_deA@mail.gmail.com>
 <CAOQ4uxgcO-Wvjwbmjme+OwVz6bZnVz4C87dgJDJQY1u55BWGjw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcO-Wvjwbmjme+OwVz6bZnVz4C87dgJDJQY1u55BWGjw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Apr 2021 17:09:05 +0200
Message-ID: <CAJfpegvRr0dy=dfLA_NM+UMYi_jqOeGf=KsS=Pjf5dn-X6nt5A@mail.gmail.com>
Subject: Re: overlayfs: overlapping upperdir path
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000006deb4805beea9d48"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000006deb4805beea9d48
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 1, 2021 at 4:30 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Apr 1, 2021 at 4:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Commit 146d62e5a586 ("ovl: detect overlapping layers") made sure we
> > don't have overapping layers, but it also broke the arguably valid use
> > case of
> >
> >  mount -olowerdir=/,upperdir=/subdir,..
> >
> > where subdir also resides on the root fs.
>
> How is 'ls /merged/subdir' expected to behave in that use case?
> Error?

-ELOOP is the error returned.

>
> >
> > I also see that we check for a trap at lookup time, so the question is
> > what does the up-front layer check buy us?
> >
>
> I'm not sure. I know it bought us silence from syzbot that started
> mutating many overlapping layers repos....
> Will the lookup trap have stopped it too? maybe. We did not try.
>
> In general I think that if we can error out to user on mount time
> it is preferred, but if we need to make that use case work, I'd try
> to relax as minimum as possible from the check.

Certainly.  Like lower inside upper makes zero sense, OTOH upper
inside lower does.   So I think we just need to relax the
upperdir/workdir layer check in this case.

Like attached patch.

Thanks,
Miklos

--0000000000006deb4805beea9d48
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="ovl-allow-upperdir-inside-lowerdir.patch"
Content-Disposition: attachment; 
	filename="ovl-allow-upperdir-inside-lowerdir.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kmz0e9tc0>
X-Attachment-Id: f_kmz0e9tc0

ZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9zdXBlci5jIGIvZnMvb3ZlcmxheWZzL3N1cGVyLmMK
aW5kZXggZmRkNzJmMWE5YzVlLi44Y2YzNDMzMzUwMjkgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlm
cy9zdXBlci5jCisrKyBiL2ZzL292ZXJsYXlmcy9zdXBlci5jCkBAIC0xODI2LDcgKzE4MjYsOCBA
QCBzdGF0aWMgc3RydWN0IG92bF9lbnRyeSAqb3ZsX2dldF9sb3dlcnN0YWNrKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsCiAgKiAtIHVwcGVyL3dvcmsgZGlyIG9mIGFueSBvdmVybGF5ZnMgaW5zdGFu
Y2UKICAqLwogc3RhdGljIGludCBvdmxfY2hlY2tfbGF5ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpz
Yiwgc3RydWN0IG92bF9mcyAqb2ZzLAotCQkJICAgc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjb25z
dCBjaGFyICpuYW1lKQorCQkJICAgc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjb25zdCBjaGFyICpu
YW1lLAorCQkJICAgYm9vbCBpc19sb3dlcikKIHsKIAlzdHJ1Y3QgZGVudHJ5ICpuZXh0ID0gZGVu
dHJ5LCAqcGFyZW50OwogCWludCBlcnIgPSAwOwpAQCAtMTgzOCw3ICsxODM5LDcgQEAgc3RhdGlj
IGludCBvdmxfY2hlY2tfbGF5ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IG92bF9m
cyAqb2ZzLAogCiAJLyogV2FsayBiYWNrIGFuY2VzdG9ycyB0byByb290IChpbmNsdXNpdmUpIGxv
b2tpbmcgZm9yIHRyYXBzICovCiAJd2hpbGUgKCFlcnIgJiYgcGFyZW50ICE9IG5leHQpIHsKLQkJ
aWYgKG92bF9sb29rdXBfdHJhcF9pbm9kZShzYiwgcGFyZW50KSkgeworCQlpZiAoaXNfbG93ZXIg
JiYgb3ZsX2xvb2t1cF90cmFwX2lub2RlKHNiLCBwYXJlbnQpKSB7CiAJCQllcnIgPSAtRUxPT1A7
CiAJCQlwcl9lcnIoIm92ZXJsYXBwaW5nICVzIHBhdGhcbiIsIG5hbWUpOwogCQl9IGVsc2UgaWYg
KG92bF9pc19pbnVzZShwYXJlbnQpKSB7CkBAIC0xODY0LDcgKzE4NjUsNyBAQCBzdGF0aWMgaW50
IG92bF9jaGVja19vdmVybGFwcGluZ19sYXllcnMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKIAog
CWlmIChvdmxfdXBwZXJfbW50KG9mcykpIHsKIAkJZXJyID0gb3ZsX2NoZWNrX2xheWVyKHNiLCBv
ZnMsIG92bF91cHBlcl9tbnQob2ZzKS0+bW50X3Jvb3QsCi0JCQkJICAgICAgInVwcGVyZGlyIik7
CisJCQkJICAgICAgInVwcGVyZGlyIiwgZmFsc2UpOwogCQlpZiAoZXJyKQogCQkJcmV0dXJuIGVy
cjsKIApAQCAtMTg3NSw3ICsxODc2LDggQEAgc3RhdGljIGludCBvdmxfY2hlY2tfb3ZlcmxhcHBp
bmdfbGF5ZXJzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJCSAqIHdvcmtiYXNlZGlyLiAgSW4g
dGhhdCBjYXNlLCB3ZSBhbHJlYWR5IGhhdmUgdGhlaXIgdHJhcHMgaW4KIAkJICogaW5vZGUgY2Fj
aGUgYW5kIHdlIHdpbGwgY2F0Y2ggdGhhdCBjYXNlIG9uIGxvb2t1cC4KIAkJICovCi0JCWVyciA9
IG92bF9jaGVja19sYXllcihzYiwgb2ZzLCBvZnMtPndvcmtiYXNlZGlyLCAid29ya2RpciIpOwor
CQllcnIgPSBvdmxfY2hlY2tfbGF5ZXIoc2IsIG9mcywgb2ZzLT53b3JrYmFzZWRpciwgIndvcmtk
aXIiLAorCQkJCSAgICAgIGZhbHNlKTsKIAkJaWYgKGVycikKIAkJCXJldHVybiBlcnI7CiAJfQpA
QCAtMTg4Myw3ICsxODg1LDcgQEAgc3RhdGljIGludCBvdmxfY2hlY2tfb3ZlcmxhcHBpbmdfbGF5
ZXJzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJZm9yIChpID0gMTsgaSA8IG9mcy0+bnVtbGF5
ZXI7IGkrKykgewogCQllcnIgPSBvdmxfY2hlY2tfbGF5ZXIoc2IsIG9mcywKIAkJCQkgICAgICBv
ZnMtPmxheWVyc1tpXS5tbnQtPm1udF9yb290LAotCQkJCSAgICAgICJsb3dlcmRpciIpOworCQkJ
CSAgICAgICJsb3dlcmRpciIsIHRydWUpOwogCQlpZiAoZXJyKQogCQkJcmV0dXJuIGVycjsKIAl9
Cg==
--0000000000006deb4805beea9d48--
