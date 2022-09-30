Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321B5F11A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI3Sbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiI3Sbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:31:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C2A220DB;
        Fri, 30 Sep 2022 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Content-Type:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WXMwv9Kvl0K3kO4pGtFjqTd7NQOAAhDPUPax69liW60=; b=nQSgfJ70Wb7BDCVco+R8DdZkqN
        aQOdw+uc+dmoanYf5RCpO9Bs2UrdFF+GoNDNCp0JdMiRYend9xVM7A1AeJBxx3pTfgqf9iVKCIkQT
        kM9S18JqF51Ld8H14H2CdHX+IiSpqaWk7aN0pkAPhny5IeREmL5QnO7QzdAuQoViyhSzPDN3c0sTs
        Cm6XVaO5LLk02C2s0H/Hg1C0SdVPYppzKoy0toEeLklaJOM/MNMKLGDWhxcJ5bMctOffNPqmFjV1z
        iSQ3aP0k5VrI7L97Rrn0lX6s8WTPeicN0T1Sm2qVK/6p+fe8qoB8E6489z6Kae1mI+685AZQ8vQdz
        sfxzbx6w==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oeKnM-000uru-On; Fri, 30 Sep 2022 20:31:32 +0200
Content-Type: multipart/mixed; boundary="------------FU96l4z8aYTBt923Pn9Octgz"
Message-ID: <101050d9-e3ec-8c21-5fb6-68442f51b39f@igalia.com>
Date:   Fri, 30 Sep 2022 15:31:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp
 interface"
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
References: <20220929215515.276486-1-gpiccoli@igalia.com>
 <202209291951.134BE2409@keescook>
 <56d85c70-80f6-aa73-ab10-20474244c7d7@igalia.com>
 <CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FU96l4z8aYTBt923Pn9Octgz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2022 12:51, Ard Biesheuvel wrote:
> [...]
> 
> Does this help?
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index b2fd3c20e7c2..c0b609d7d04e 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -292,7 +292,7 @@ static int pstore_compress(const void *in, void *out,
>                 return ret;
>         }
> 
> -       return outlen;
> +       return creq->dlen;
>  }
> 
>  static void allocate_buf_for_compression(void)
> 

Thanks a lot Ard, this seems to be the fix! Tested with lz4/zstd/deflate
in both ramoops/efi backends, and all worked fine. It makes sense,
outlen was modified in the previous API and not in the acomp thing, so
it was a good catch =)


>> Heheh you're right! But for something like this (pstore/dmesg
>> compression broke for the most backends), I'd be glad if we could fix it
>> before the release.
> 
> Yeah better to revert - this was not a critical change anyway. But I
> think the tweak above should fix things (it works for me here)

Agreed - in fact seems it was reverted already. More than that, I found
yet another small issue in the acomp refactor, a memory leak - attached
is a patch with the fix, feel free to integrate in your acomp refactor
when re-submitting (I mean, feel free to just integrate the code, don't
need to send it as a separate patch/fix).

I'm also working some fixes in implicit conversions in pstore that
aren't great (unsigned -> int in many places), I'll send some stuff next
week.

Cheers,


Guilherme
--------------FU96l4z8aYTBt923Pn9Octgz
Content-Type: text/x-patch; charset=UTF-8;
 name="pstore-Fix-memory-leak-after-the-recent-compression-.patch"
Content-Disposition: attachment;
 filename*0="pstore-Fix-memory-leak-after-the-recent-compression-.patch"
Content-Transfer-Encoding: base64

RnJvbSBjZjA1MTVkZWMxYTMzOWU3YjY0NGNiYWRhZjU4YmZiNTRjOWIyMGRmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiR3VpbGhlcm1lIEcuIFBpY2NvbGkiIDxncGljY29s
aUBpZ2FsaWEuY29tPgpEYXRlOiBGcmksIDMwIFNlcCAyMDIyIDEzOjQ1OjE4IC0wMzAwClN1
YmplY3Q6IFtQQVRDSF0gcHN0b3JlOiBGaXggbWVtb3J5IGxlYWsgYWZ0ZXIgdGhlIHJlY2Vu
dCBjb21wcmVzc2lvbiByZWZhY3RvcgoKRml4ZXM6IGU0ZjBhN2VjNTg2YiAoInBzdG9yZTog
bWlncmF0ZSB0byBjcnlwdG8gYWNvbXAgaW50ZXJmYWNlIikKQ2M6IEFyZCBCaWVzaGV1dmVs
IDxhcmRiQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEd1aWxoZXJtZSBHLiBQaWNjb2xp
IDxncGljY29saUBpZ2FsaWEuY29tPgotLS0KIGZzL3BzdG9yZS9wbGF0Zm9ybS5jIHwgMSAr
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9mcy9wc3Rv
cmUvcGxhdGZvcm0uYyBiL2ZzL3BzdG9yZS9wbGF0Zm9ybS5jCmluZGV4IGQyNDRkYjhjODc5
ZC4uMTc2NWVhMTU3ZDM3IDEwMDY0NAotLS0gYS9mcy9wc3RvcmUvcGxhdGZvcm0uYworKysg
Yi9mcy9wc3RvcmUvcGxhdGZvcm0uYwpAQCAtNzQxLDYgKzc0MSw3IEBAIHN0YXRpYyB2b2lk
IGRlY29tcHJlc3NfcmVjb3JkKHN0cnVjdCBwc3RvcmVfcmVjb3JkICpyZWNvcmQpCiAJcmV0
ID0gY3J5cHRvX2Fjb21wX2RlY29tcHJlc3MoZHJlcSk7CiAJaWYgKHJldCkgewogCQlwcl9l
cnIoImNyeXB0b19hY29tcF9kZWNvbXByZXNzIGZhaWxlZCwgcmV0ID0gJWQhXG4iLCByZXQp
OworCQlhY29tcF9yZXF1ZXN0X2ZyZWUoZHJlcSk7CiAJCWtmcmVlKHdvcmtzcGFjZSk7CiAJ
CXJldHVybjsKIAl9Ci0tIAoyLjM3LjMKCg==

--------------FU96l4z8aYTBt923Pn9Octgz--
