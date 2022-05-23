Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89348530752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 03:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352066AbiEWBvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 21:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352128AbiEWBvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 21:51:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF4EAC
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:50:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so12331291pju.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to;
        bh=HIYwi79oVjYHc3KTI/fFLea3RFpkzO3pqk0WrDiDbnc=;
        b=dl7+7aH1ur+/uMNjqVA/mju35una4oDLd7xnc2xJ9uxea4qlFczzkjnncK8w/fDgL9
         xrZxDDSKA8eb4KNhMJhZOjl+qY19y41jgkcuYqvTFtUsQxY5rtLIwgUdzbAB5vTuHtdM
         vkQBlmrc1twbn+q8LSSi0eipGAuEM9tWXOdnz6KcJzKybVULkGtxfUUjKFKQR8Qknhtc
         ZuY+VRZXvbC1OEHqToqh03cLCkYHPrw/Z+C7IifeJbhnvjvMhEiR7t0/jtBwH0Au453s
         vQBbGN4nPVyFxMghIImEJjQifXMym5sv28rmsok13w8ZFglYDHHeiO4nOTXvprFzAJAb
         HQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to;
        bh=HIYwi79oVjYHc3KTI/fFLea3RFpkzO3pqk0WrDiDbnc=;
        b=sbvA192XZbXjfsVZ2NSAXpWauN+2O8SsQAz8eidb7cMSOHRaw5YyKlx06S59HBqts3
         pvfwUhSxOJaf7pLBlTNacUJDE/vr1uHg3cLB3OnMOwAVayKxFJVj9U6wINDQEYWwYfKV
         wi8PySexo+iosJy+bBFHFCzQnOCPzJx+ZpTZgJrL+p9JVqAmEY7ZtAq/jRjtRMTwL7Rz
         7Oog6nS+ZpQxbHJG9r4w95lPspfgrHnflYo7LIh/9fuEzLi2LDEsj0oLOa47xi7JY917
         oKCYOoATCTNbo8YLWnryRKAFLBcH8Dqlgb1UPhWRPJBjgZOXAdlgDIm6RaTtMrgBaFD4
         iVwg==
X-Gm-Message-State: AOAM532/IOA6ToxY34Lk71jKIT/xFj8DTKczcGP9y4/W++wxjlZ4HBwp
        s/Bvrm8RK6IsH3jinJ0w7jgHWQ==
X-Google-Smtp-Source: ABdhPJz0OYQjNULDHoTIWHggMZgY6PIsUMF/XEhvAm+xnCMfUKfQ+eKZHlORRuAElMX8mREuh82hLQ==
X-Received: by 2002:a17:90a:4587:b0:1de:c6ee:80f with SMTP id v7-20020a17090a458700b001dec6ee080fmr24341326pjg.196.1653270657377;
        Sun, 22 May 2022 18:50:57 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a3d0e00b001dfffd861cbsm5160852pjc.21.2022.05.22.18.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:50:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------6hcMK2hMv9iQi0tJFoERCduy"
Message-ID: <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
Date:   Sun, 22 May 2022 19:50:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
In-Reply-To: <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6hcMK2hMv9iQi0tJFoERCduy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/22 7:28 PM, Jens Axboe wrote:
> On 5/22/22 7:22 PM, Jens Axboe wrote:
>> On 5/22/22 6:42 PM, Al Viro wrote:
>>> On Sun, May 22, 2022 at 02:03:35PM -0600, Jens Axboe wrote:
>>>
>>>> Right, I'm saying it's not _immediately_ clear which cases are what when
>>>> reading the code.
>>>>
>>>>> up a while ago.  And no, turning that into indirect calls ended up with
>>>>> arseloads of overhead, more's the pity...
>>>>
>>>> It's a shame, since indirect calls make for nicer code, but it's always
>>>> been slower and these days even more so.
>>>>
>>>>> Anyway, at the moment I have something that builds; hadn't tried to
>>>>> boot it yet.
>>>>
>>>> Nice!
>>>
>>> Boots and survives LTP and xfstests...  Current variant is in
>>> vfs.git#work.iov_iter (head should be at 27fa77a9829c).  I have *not*
>>> looked into the code generation in primitives; the likely/unlikely on
>>> those cascades of ifs need rethinking.
>>
>> I noticed too. Haven't fiddled much in iov_iter.c, but for uio.h I had
>> the below. iov_iter.c is a worse "offender" though, with 53 unlikely and
>> 22 likely annotations...
> 
> Here it is...

Few more, most notably making sure that dio dirties reads even if they
are not of the iovec type.

Last two just add a helper for import_ubuf() and then adopts it for
io_uring send/recv which is also a hot path. The single range read/write
can be converted too, but that needs a bit more work...

-- 
Jens Axboe

--------------6hcMK2hMv9iQi0tJFoERCduy
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-io_uring-use-import_ubuf-for-send-recv.patch"
Content-Disposition: attachment;
 filename="0004-io_uring-use-import_ubuf-for-send-recv.patch"
Content-Transfer-Encoding: base64

RnJvbSBkMDViNTlkYzEwZTZjN2M3NGRhNDM5NTYxODMxZjc0NDE5NmViNDEyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgMjIgTWF5IDIwMjIgMTk6NDk6MzYgLTA2MDAKU3ViamVjdDogW1BBVENIIDQv
NF0gaW9fdXJpbmc6IHVzZSBpbXBvcnRfdWJ1ZigpIGZvciBzZW5kL3JlY3YKCldlIGp1c3Qg
aGF2ZSB0aGUgc2luZ2xlIGJ1ZmZlciwgbm8gcG9pbnQgaW4gdXNpbmcgSVRFUl9JT1ZFQyB3
aGVuIHdlCmNhbiBiZSB1c2luZyB0aGUgbW9yZSBlZmZpY2llbnQgSVRFUl9VQlVGIGluc3Rl
YWQuCgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQog
ZnMvaW9fdXJpbmcuYyB8IDYgKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2lvX3VyaW5nLmMgYi9mcy9p
b191cmluZy5jCmluZGV4IDczZjUzYzIwOGRmMi4uOTEyNTVmMjMyNmU1IDEwMDY0NAotLS0g
YS9mcy9pb191cmluZy5jCisrKyBiL2ZzL2lvX3VyaW5nLmMKQEAgLTUyNzIsNyArNTI3Miw2
IEBAIHN0YXRpYyBpbnQgaW9fc2VuZChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQg
aW50IGlzc3VlX2ZsYWdzKQogewogCXN0cnVjdCBpb19zcl9tc2cgKnNyID0gJnJlcS0+c3Jf
bXNnOwogCXN0cnVjdCBtc2doZHIgbXNnOwotCXN0cnVjdCBpb3ZlYyBpb3Y7CiAJc3RydWN0
IHNvY2tldCAqc29jazsKIAl1bnNpZ25lZCBmbGFnczsKIAlpbnQgbWluX3JldCA9IDA7CkBA
IC01MjgyLDcgKzUyODEsNyBAQCBzdGF0aWMgaW50IGlvX3NlbmQoc3RydWN0IGlvX2tpb2Ni
ICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAlpZiAodW5saWtlbHkoIXNvY2sp
KQogCQlyZXR1cm4gLUVOT1RTT0NLOwogCi0JcmV0ID0gaW1wb3J0X3NpbmdsZV9yYW5nZShX
UklURSwgc3ItPmJ1Ziwgc3ItPmxlbiwgJmlvdiwgJm1zZy5tc2dfaXRlcik7CisJcmV0ID0g
aW1wb3J0X3VidWYoV1JJVEUsIHNyLT5idWYsIHNyLT5sZW4sICZtc2cubXNnX2l0ZXIpOwog
CWlmICh1bmxpa2VseShyZXQpKQogCQlyZXR1cm4gcmV0OwogCkBAIC01NTIxLDcgKzU1MjAs
NiBAQCBzdGF0aWMgaW50IGlvX3JlY3Yoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVk
IGludCBpc3N1ZV9mbGFncykKIAlzdHJ1Y3QgbXNnaGRyIG1zZzsKIAl2b2lkIF9fdXNlciAq
YnVmID0gc3ItPmJ1ZjsKIAlzdHJ1Y3Qgc29ja2V0ICpzb2NrOwotCXN0cnVjdCBpb3ZlYyBp
b3Y7CiAJdW5zaWduZWQgZmxhZ3M7CiAJaW50IHJldCwgbWluX3JldCA9IDA7CiAJYm9vbCBm
b3JjZV9ub25ibG9jayA9IGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9OT05CTE9DSzsKQEAg
LTU1MzcsNyArNTUzNSw3IEBAIHN0YXRpYyBpbnQgaW9fcmVjdihzdHJ1Y3QgaW9fa2lvY2Ig
KnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCQlidWYgPSB1NjRfdG9fdXNlcl9w
dHIoa2J1Zi0+YWRkcik7CiAJfQogCi0JcmV0ID0gaW1wb3J0X3NpbmdsZV9yYW5nZShSRUFE
LCBidWYsIHNyLT5sZW4sICZpb3YsICZtc2cubXNnX2l0ZXIpOworCXJldCA9IGltcG9ydF91
YnVmKFJFQUQsIGJ1Ziwgc3ItPmxlbiwgJm1zZy5tc2dfaXRlcik7CiAJaWYgKHVubGlrZWx5
KHJldCkpCiAJCWdvdG8gb3V0X2ZyZWU7CiAKLS0gCjIuMzUuMQoK
--------------6hcMK2hMv9iQi0tJFoERCduy
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-iov-add-import_ubuf.patch"
Content-Disposition: attachment; filename="0003-iov-add-import_ubuf.patch"
Content-Transfer-Encoding: base64

RnJvbSA1Nzg2YjFkYjBiZjQzMzEzMDkyZTYxNzk3ZjYzOTI5MDA3OWIyNzA5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgMjIgTWF5IDIwMjIgMTk6NDc6MjkgLTA2MDAKU3ViamVjdDogW1BBVENIIDMv
NF0gaW92OiBhZGQgaW1wb3J0X3VidWYoKQoKTGlrZSBpbXBvcnRfc2luZ2xlX3JhbmdlKCks
IGJ1dCBmb3IgSVRFUl9VQlVGLgoKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VA
a2VybmVsLmRrPgotLS0KIGluY2x1ZGUvbGludXgvdWlvLmggfCAgMSArCiBsaWIvaW92X2l0
ZXIuYyAgICAgIHwgMTEgKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdWlvLmggYi9pbmNsdWRlL2xp
bnV4L3Vpby5oCmluZGV4IGQxMGMxOWE2NTBhOC4uNGU0NzNlYTkwYjIwIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L3Vpby5oCisrKyBiL2luY2x1ZGUvbGludXgvdWlvLmgKQEAgLTMz
MSw2ICszMzEsNyBAQCBzc2l6ZV90IF9faW1wb3J0X2lvdmVjKGludCB0eXBlLCBjb25zdCBz
dHJ1Y3QgaW92ZWMgX191c2VyICp1dmVjLAogCQkgc3RydWN0IGlvdl9pdGVyICppLCBib29s
IGNvbXBhdCk7CiBpbnQgaW1wb3J0X3NpbmdsZV9yYW5nZShpbnQgdHlwZSwgdm9pZCBfX3Vz
ZXIgKmJ1Ziwgc2l6ZV90IGxlbiwKIAkJIHN0cnVjdCBpb3ZlYyAqaW92LCBzdHJ1Y3QgaW92
X2l0ZXIgKmkpOworaW50IGltcG9ydF91YnVmKGludCB0eXBlLCB2b2lkIF9fdXNlciAqYnVm
LCBzaXplX3QgbGVuLCBzdHJ1Y3QgaW92X2l0ZXIgKmkpOwogCiBzdGF0aWMgaW5saW5lIHZv
aWQgaW92X2l0ZXJfdWJ1ZihzdHJ1Y3QgaW92X2l0ZXIgKmksIHVuc2lnbmVkIGludCBkaXJl
Y3Rpb24sCiAJCQl2b2lkIF9fdXNlciAqYnVmLCBzaXplX3QgY291bnQpCmRpZmYgLS1naXQg
YS9saWIvaW92X2l0ZXIuYyBiL2xpYi9pb3ZfaXRlci5jCmluZGV4IGFhNDEzOTQxNzRlYi4u
MzQ4NDEyNzU3MzM1IDEwMDY0NAotLS0gYS9saWIvaW92X2l0ZXIuYworKysgYi9saWIvaW92
X2l0ZXIuYwpAQCAtMjE2Nyw2ICsyMTY3LDE3IEBAIGludCBpbXBvcnRfc2luZ2xlX3Jhbmdl
KGludCBydywgdm9pZCBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGxlbiwKIH0KIEVYUE9SVF9TWU1C
T0woaW1wb3J0X3NpbmdsZV9yYW5nZSk7CiAKK2ludCBpbXBvcnRfdWJ1ZihpbnQgcncsIHZv
aWQgX191c2VyICpidWYsIHNpemVfdCBsZW4sIHN0cnVjdCBpb3ZfaXRlciAqaSkKK3sKKwlp
ZiAobGVuID4gTUFYX1JXX0NPVU5UKQorCQlsZW4gPSBNQVhfUldfQ09VTlQ7CisJaWYgKHVu
bGlrZWx5KCFhY2Nlc3Nfb2soYnVmLCBsZW4pKSkKKwkJcmV0dXJuIC1FRkFVTFQ7CisKKwlp
b3ZfaXRlcl91YnVmKGksIHJ3LCBidWYsIGxlbik7CisJcmV0dXJuIDA7Cit9CisKIC8qKgog
ICogaW92X2l0ZXJfcmVzdG9yZSgpIC0gUmVzdG9yZSBhICZzdHJ1Y3QgaW92X2l0ZXIgdG8g
dGhlIHNhbWUgc3RhdGUgYXMgd2hlbgogICogICAgIGlvdl9pdGVyX3NhdmVfc3RhdGUoKSB3
YXMgY2FsbGVkLgotLSAKMi4zNS4xCgo=
--------------6hcMK2hMv9iQi0tJFoERCduy
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-Switch-iter_is_iovec-checks-for-user-memory-with-ite.patch"
Content-Disposition: attachment;
 filename*0="0002-Switch-iter_is_iovec-checks-for-user-memory-with-ite.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjYzhiZmQ2NGMxYThkNzU0MjMwODA5YTU2YmYyM2JjYWRlYWJkNjNmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgMjIgTWF5IDIwMjIgMTk6Mzc6MzMgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
NF0gU3dpdGNoIGl0ZXJfaXNfaW92ZWMoKSBjaGVja3MgZm9yIHVzZXIgbWVtb3J5IHdpdGgK
IGl0ZXJfaXNfdXNlcigpCgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJu
ZWwuZGs+Ci0tLQogYmxvY2svZm9wcy5jICAgICAgICAgfCA3ICsrKy0tLS0KIGZzL2RpcmVj
dC1pby5jICAgICAgIHwgMiArLQogZnMvaW9tYXAvZGlyZWN0LWlvLmMgfCAyICstCiBmcy9u
ZnMvZGlyZWN0LmMgICAgICB8IDIgKy0KIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2ZvcHMuYyBiL2Jsb2Nr
L2ZvcHMuYwppbmRleCBiMWY3YzQxMTE0NTguLjE1Nzg4YTM2OTgzYSAxMDA2NDQKLS0tIGEv
YmxvY2svZm9wcy5jCisrKyBiL2Jsb2NrL2ZvcHMuYwpAQCAtNzcsOCArNzcsNyBAQCBzdGF0
aWMgc3NpemVfdCBfX2Jsa2Rldl9kaXJlY3RfSU9fc2ltcGxlKHN0cnVjdCBraW9jYiAqaW9j
YiwKIAogCWlmIChpb3ZfaXRlcl9ydyhpdGVyKSA9PSBSRUFEKSB7CiAJCWJpb19pbml0KCZi
aW8sIGJkZXYsIHZlY3MsIG5yX3BhZ2VzLCBSRVFfT1BfUkVBRCk7Ci0JCWlmIChpdGVyX2lz
X2lvdmVjKGl0ZXIpKQotCQkJc2hvdWxkX2RpcnR5ID0gdHJ1ZTsKKwkJc2hvdWxkX2RpcnR5
ID0gaXRlcl9pc191c2VyKGl0ZXIpOwogCX0gZWxzZSB7CiAJCWJpb19pbml0KCZiaW8sIGJk
ZXYsIHZlY3MsIG5yX3BhZ2VzLCBkaW9fYmlvX3dyaXRlX29wKGlvY2IpKTsKIAl9CkBAIC0y
MTcsNyArMjE2LDcgQEAgc3RhdGljIHNzaXplX3QgX19ibGtkZXZfZGlyZWN0X0lPKHN0cnVj
dCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICppdGVyLAogCX0KIAogCWRpby0+c2l6
ZSA9IDA7Ci0JaWYgKGlzX3JlYWQgJiYgaXRlcl9pc19pb3ZlYyhpdGVyKSkKKwlpZiAoaXNf
cmVhZCAmJiBpdGVyX2lzX3VzZXIoaXRlcikpCiAJCWRpby0+ZmxhZ3MgfD0gRElPX1NIT1VM
RF9ESVJUWTsKIAogCWJsa19zdGFydF9wbHVnKCZwbHVnKTsKQEAgLTM0Niw3ICszNDUsNyBA
QCBzdGF0aWMgc3NpemVfdCBfX2Jsa2Rldl9kaXJlY3RfSU9fYXN5bmMoc3RydWN0IGtpb2Ni
ICppb2NiLAogCWRpby0+c2l6ZSA9IGJpby0+YmlfaXRlci5iaV9zaXplOwogCiAJaWYgKGlz
X3JlYWQpIHsKLQkJaWYgKGl0ZXJfaXNfaW92ZWMoaXRlcikpIHsKKwkJaWYgKGl0ZXJfaXNf
dXNlcihpdGVyKSkgewogCQkJZGlvLT5mbGFncyB8PSBESU9fU0hPVUxEX0RJUlRZOwogCQkJ
YmlvX3NldF9wYWdlc19kaXJ0eShiaW8pOwogCQl9CmRpZmYgLS1naXQgYS9mcy9kaXJlY3Qt
aW8uYyBiL2ZzL2RpcmVjdC1pby5jCmluZGV4IDU2ZGM1YTdhZDExOS4uNWNmYTUzZTA3ODNm
IDEwMDY0NAotLS0gYS9mcy9kaXJlY3QtaW8uYworKysgYi9mcy9kaXJlY3QtaW8uYwpAQCAt
MTI0Niw3ICsxMjQ2LDcgQEAgZG9fYmxvY2tkZXZfZGlyZWN0X0lPKHN0cnVjdCBraW9jYiAq
aW9jYiwgc3RydWN0IGlub2RlICppbm9kZSwKIAlzcGluX2xvY2tfaW5pdCgmZGlvLT5iaW9f
bG9jayk7CiAJZGlvLT5yZWZjb3VudCA9IDE7CiAKLQlkaW8tPnNob3VsZF9kaXJ0eSA9IGl0
ZXJfaXNfaW92ZWMoaXRlcikgJiYgaW92X2l0ZXJfcncoaXRlcikgPT0gUkVBRDsKKwlkaW8t
PnNob3VsZF9kaXJ0eSA9IGl0ZXJfaXNfdXNlcihpdGVyKSAmJiBpb3ZfaXRlcl9ydyhpdGVy
KSA9PSBSRUFEOwogCXNkaW8uaXRlciA9IGl0ZXI7CiAJc2Rpby5maW5hbF9ibG9ja19pbl9y
ZXF1ZXN0ID0gZW5kID4+IGJsa2JpdHM7CiAKZGlmZiAtLWdpdCBhL2ZzL2lvbWFwL2RpcmVj
dC1pby5jIGIvZnMvaW9tYXAvZGlyZWN0LWlvLmMKaW5kZXggMzNiOTRlMzMxODlhLi43ZDIx
MmJkZTEwMWEgMTAwNjQ0Ci0tLSBhL2ZzL2lvbWFwL2RpcmVjdC1pby5jCisrKyBiL2ZzL2lv
bWFwL2RpcmVjdC1pby5jCkBAIC01MjMsNyArNTIzLDcgQEAgX19pb21hcF9kaW9fcncoc3Ry
dWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCiAJCQlpb21pLmZsYWdz
IHw9IElPTUFQX05PV0FJVDsKIAkJfQogCi0JCWlmIChpdGVyX2lzX2lvdmVjKGl0ZXIpKQor
CQlpZiAoaXRlcl9pc191c2VyKGl0ZXIpKQogCQkJZGlvLT5mbGFncyB8PSBJT01BUF9ESU9f
RElSVFk7CiAJfSBlbHNlIHsKIAkJaW9taS5mbGFncyB8PSBJT01BUF9XUklURTsKZGlmZiAt
LWdpdCBhL2ZzL25mcy9kaXJlY3QuYyBiL2ZzL25mcy9kaXJlY3QuYwppbmRleCAxMWM1NjZk
ODc2OWYuLmI2MTI1ZDVhMjVjNiAxMDA2NDQKLS0tIGEvZnMvbmZzL2RpcmVjdC5jCisrKyBi
L2ZzL25mcy9kaXJlY3QuYwpAQCAtNDgxLDcgKzQ4MSw3IEBAIHNzaXplX3QgbmZzX2ZpbGVf
ZGlyZWN0X3JlYWQoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIs
CiAJaWYgKCFpc19zeW5jX2tpb2NiKGlvY2IpKQogCQlkcmVxLT5pb2NiID0gaW9jYjsKIAot
CWlmIChpdGVyX2lzX2lvdmVjKGl0ZXIpKQorCWlmIChpdGVyX2lzX3VzZXIoaXRlcikpCiAJ
CWRyZXEtPmZsYWdzID0gTkZTX09ESVJFQ1RfU0hPVUxEX0RJUlRZOwogCiAJaWYgKCFzd2Fw
KQotLSAKMi4zNS4xCgo=
--------------6hcMK2hMv9iQi0tJFoERCduy
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-iov-add-iter_is_user.patch"
Content-Disposition: attachment; filename="0001-iov-add-iter_is_user.patch"
Content-Transfer-Encoding: base64

RnJvbSA5OTJlMDNlMGJkODc4MDFjMzVmNWM2ZDg4NTUzOTZmYzQ4MTM4N2I4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgMjIgTWF5IDIwMjIgMTk6MzQ6NDUgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
NF0gaW92OiBhZGQgaXRlcl9pc191c2VyKCkKClJldHVybnMgdHJ1ZSBpZiB0aGUgaXRlciBp
cyBob2xkaW5nIHVzZXIgbWVtb3J5LiBVc2UgdGhhdCBmb3IgdGhlCm1pZ2h0X2ZhdWx0KCkg
Y2hlY2tzLgoKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgot
LS0KIGluY2x1ZGUvbGludXgvdWlvLmggfCA1ICsrKysrCiBsaWIvaW92X2l0ZXIuYyAgICAg
IHwgNiArKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdWlvLmggYi9pbmNsdWRlL2xp
bnV4L3Vpby5oCmluZGV4IDUyYmFhM2M4OTUwNS4uZDEwYzE5YTY1MGE4IDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L3Vpby5oCisrKyBiL2luY2x1ZGUvbGludXgvdWlvLmgKQEAgLTEx
Miw2ICsxMTIsMTEgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBjaGFyIGlvdl9pdGVyX3J3
KGNvbnN0IHN0cnVjdCBpb3ZfaXRlciAqaSkKIAlyZXR1cm4gaS0+ZGF0YV9zb3VyY2UgPyBX
UklURSA6IFJFQUQ7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCBpdGVyX2lzX3VzZXIoY29u
c3Qgc3RydWN0IGlvdl9pdGVyICppKQoreworCXJldHVybiBpdGVyX2lzX2lvdmVjKGkpIHx8
IGl0ZXJfaXNfdWJ1ZihpKTsKK30KKwogLyoKICAqIFRvdGFsIG51bWJlciBvZiBieXRlcyBj
b3ZlcmVkIGJ5IGFuIGlvdmVjLgogICoKZGlmZiAtLWdpdCBhL2xpYi9pb3ZfaXRlci5jIGIv
bGliL2lvdl9pdGVyLmMKaW5kZXggMDgyOTY3NjlmNWM2Li5hYTQxMzk0MTc0ZWIgMTAwNjQ0
Ci0tLSBhL2xpYi9pb3ZfaXRlci5jCisrKyBiL2xpYi9pb3ZfaXRlci5jCkBAIC03NjcsNyAr
NzY3LDcgQEAgc2l6ZV90IF9jb3B5X3RvX2l0ZXIoY29uc3Qgdm9pZCAqYWRkciwgc2l6ZV90
IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKmkpCiB7CiAJaWYgKHVubGlrZWx5KGlvdl9pdGVy
X2lzX3BpcGUoaSkpKQogCQlyZXR1cm4gY29weV9waXBlX3RvX2l0ZXIoYWRkciwgYnl0ZXMs
IGkpOwotCWlmIChpdGVyX2lzX2lvdmVjKGkpIHx8IGl0ZXJfaXNfdWJ1ZihpKSkKKwlpZiAo
aXRlcl9pc191c2VyKGkpKQogCQltaWdodF9mYXVsdCgpOwogCWl0ZXJhdGVfYW5kX2FkdmFu
Y2UoaSwgYnl0ZXMsIGJhc2UsIGxlbiwgb2ZmLAogCQljb3B5b3V0KGJhc2UsIGFkZHIgKyBv
ZmYsIGxlbiksCkBAIC04NDksNyArODQ5LDcgQEAgc2l6ZV90IF9jb3B5X21jX3RvX2l0ZXIo
Y29uc3Qgdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBzdHJ1Y3QgaW92X2l0ZXIgKmkpCiB7
CiAJaWYgKHVubGlrZWx5KGlvdl9pdGVyX2lzX3BpcGUoaSkpKQogCQlyZXR1cm4gY29weV9t
Y19waXBlX3RvX2l0ZXIoYWRkciwgYnl0ZXMsIGkpOwotCWlmIChpdGVyX2lzX2lvdmVjKGkp
IHx8IGl0ZXJfaXNfdWJ1ZihpKSkKKwlpZiAoaXRlcl9pc191c2VyKGkpKQogCQltaWdodF9m
YXVsdCgpOwogCV9faXRlcmF0ZV9hbmRfYWR2YW5jZShpLCBieXRlcywgYmFzZSwgbGVuLCBv
ZmYsCiAJCWNvcHlvdXRfbWMoYmFzZSwgYWRkciArIG9mZiwgbGVuKSwKQEAgLTg2Nyw3ICs4
NjcsNyBAQCBzaXplX3QgX2NvcHlfZnJvbV9pdGVyKHZvaWQgKmFkZHIsIHNpemVfdCBieXRl
cywgc3RydWN0IGlvdl9pdGVyICppKQogCQlXQVJOX09OKDEpOwogCQlyZXR1cm4gMDsKIAl9
Ci0JaWYgKGl0ZXJfaXNfaW92ZWMoaSkgfHwgaXRlcl9pc191YnVmKGkpKQorCWlmIChpdGVy
X2lzX3VzZXIoaSkpCiAJCW1pZ2h0X2ZhdWx0KCk7CiAJaXRlcmF0ZV9hbmRfYWR2YW5jZShp
LCBieXRlcywgYmFzZSwgbGVuLCBvZmYsCiAJCWNvcHlpbihhZGRyICsgb2ZmLCBiYXNlLCBs
ZW4pLAotLSAKMi4zNS4xCgo=

--------------6hcMK2hMv9iQi0tJFoERCduy--
