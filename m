Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D512962EE54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiKRHaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240802AbiKRHaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:30:00 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF547D528
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 23:29:55 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a36so1432185uax.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 23:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9uCdirb6MiCW2x9lXoceLJSxaHNb+ffrxkmuNGlpjQI=;
        b=FtsTVVBcBZoj4JvMZ8Tmbkj1vyFnzw0yPL3Mwy6nWlgF2DTA2tyrXY6h+6IG7iU804
         KjogTvi93VYZ87q+GNPTviWvX3Ur+ww5WzSUCdEEUWVbqLc+1STOX0YumBWjA0vbX/lj
         oqCcYgFdSEnXKpfi/F2eUrwD77oxM4Gx+uc7rSdG1izo4zGOGEH1yBWHYfrXoKL0TelW
         hvcqgzq5bIE1wXxRxZzeUc+B9cPP002GSF1ix6Npks7J/AHxrV0vprYT63Wv2EYQ7YIj
         CLU2YhgtUx5lDuD3RAcmWrZqjjY6wfFKVyUYrDvnfhtSCiIdp0uuyDwZ/gdls6VgONnY
         ljoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uCdirb6MiCW2x9lXoceLJSxaHNb+ffrxkmuNGlpjQI=;
        b=xR4/SRnBhPau+lmZjDuRv3wqOTRjGRNrt74DjxiqqLenxORyB6bZyXbhkGmBYyNG9s
         UzoIS8jKQ8nQzIms/uBh4kHbTX0Oi+iop/ARPKK2t+XxIgqLegxhgjX9q9uDDOHYUCx3
         lwnMmIpXkTg4bzrONvhIDDEBZQwgQ5QePJRN2kxWImWH/RCmbxZABLQJXsr3mBIzFiFk
         ZUQZVwWBFbqH0eIvUP4URbqw1GzEcSH+Z+swpeFN1B9C/xb7hnWxyDKWeS9NaXRSMntc
         7Hrah6G2SQTfjN2/5uRS/YQ9bZ0Pavi0Vjl5aaxm4vMeHwFiAD7Z40p/mXx2RTt9ilUj
         j4mg==
X-Gm-Message-State: ANoB5pkDOwmgwgrejxVh4MQTZQSgnViw34auPtbzOEH/kgdRnjXhquko
        g+jR9xSdUUZ9RYLBzlJAOS41OSyJdC/YCiZb8OxWLQ==
X-Google-Smtp-Source: AA0mqf4KU6A3b6Li3zUpy2Lk4NYsLCO5Vb2lIVcs9rriQ0Q+7mChaGrUEW7i5q9Wla6p3bnPzAWT9xBCYnFvII50m5Y=
X-Received: by 2002:ab0:238f:0:b0:411:968:212 with SMTP id b15-20020ab0238f000000b0041109680212mr3471849uan.107.1668756594737;
 Thu, 17 Nov 2022 23:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20221106021657.1145519-1-pedro.falcato@gmail.com>
 <202211061948.46D3F78@keescook> <CABVgOSm9V37KgiP-eHxfYF4tTT+ZDQKVxEAzh8P0SH3WrECM9A@mail.gmail.com>
 <202211171402.95121B3FD4@keescook>
In-Reply-To: <202211171402.95121B3FD4@keescook>
From:   David Gow <davidgow@google.com>
Date:   Fri, 18 Nov 2022 15:29:43 +0800
Message-ID: <CABVgOSkgzo0bE5iHWB5HdMokgyEcbw-R-MrrnvD-QBzsHmz4OQ@mail.gmail.com>
Subject: Re: Attaching userspace VM to kernel thread (was Re: [PATCH]
 fs/binfmt_elf: Fix memsz > filesz handling)
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, sam@gentoo.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000011331e05edb9ac94"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000011331e05edb9ac94
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 18, 2022 at 6:06 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> This has diverged from the original topic a bit, so I've changed the
> Subject to hopefully gain visibility. :)
>
> For KUnit, it would be REALLY nice to have a way to attach a userspace
> VM to a kernel thread so we can do userspace memory mapping
> manipulation, etc. Neither David nor I have been able to figure out the
> right set of steps to make this happen. What are we missing?
>
> Details below...
>
> On Wed, Nov 16, 2022 at 12:34:40PM +0800, David Gow wrote:
> > On Mon, Nov 7, 2022 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Sun, Nov 06, 2022 at 02:16:57AM +0000, Pedro Falcato wrote:
> > > David, has there been any work on adding a way to instantiate
> > > userspace VMAs in a KUnit test? I tried to write this myself, but I
> > > couldn't figure out how to make the userspace memory mappings appear.
> > > Here's my fumbling attempt:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/kunit/usercopy
> > >
> > > I really wish KUnit had userspace mapping support -- I have a bunch of
> > > unit tests that need to get built up around checking for regressions
> > > here, etc.
> >
> > Hi Kees,
> >
> > Sorry the the delayed response!
> >
> > Alas, my attempts to get this to work haven't been much more
> > successful than yours. It's definitely something we'd like to support,
> > but I confess to not knowing enough about the mm code to know exactly
> > what would be involved.
> >
> > The workaround is to load tests as modules, and use something like
> > Vitor's original patch here:
> > https://lore.kernel.org/all/20200721174036.71072-1-vitor@massaru.org/
> >
> > Basically, using the existing mm of the module loader. Adapting those
> > changes to your branch (and fixing a couple of back-to-front KUnit
> > assertions) does work for me when built as a module, in an x86_64 vm:
> >
> > root@slicestar:~# modprobe usercopy_kunit
> > [   52.986290]     # Subtest: usercopy
> > [   52.986701]     1..1
> > [   53.246058]     ok 1 - usercopy_test
> > [   53.246628] ok 1 - usercopy
> >
> > But getting it to work with built-in tests hasn't been successful so
> > far. I wondered if we could just piggy-back on init_mm or similar, but
> > that doesn't seem to work either.
> >
> > So, in the short-term, this is only possible for modules. If that's
> > useful enough, we can get Vitor's support patch (or something similar)
> > in, and just mark any tests module-only (or have them skip if there's
> > no mm). Because kunit.py only runs built-in tests, though, it's
> > definitely less convenient.
>
> Thanks for any pointers! :)
>
> -Kees
>
> --
> Kees Cook

FWIW, I had another quick look at this yesterday, and I suspect that
(at least one of) the problem(s) is that function pointers like
mm->get_unmapped_area are only setup as part of exec(), so a
newly-created mm isn't actually useful. Looking at, e.g.,
arch_pick_mm_layout(), there's a whole bunch of architecture-dependent
stuff here to handle, e.g., 32-bit compat.

Cheers,
-- David

--00000000000011331e05edb9ac94
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBt
BnmZClgogfWv5FzalR+xus5U5/TflBIUxCsalBF2gTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTgwNzI5NTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAK/pw2+1Xh4BweEn3qq0R
J4ATnlmGcn4ws/Hj1JsxHiAyKRumkk1WK4ARdsLrYwVgqRRsXJs2GlyHNdqzSV8h+tQh2KMMKmST
Y6+MQLy74Cxi+suo3pXutuw6/uqmhS6Xlhme6ChdDu3mhBFQgNxuzc879aX4lY466fTuAKYIxLQ6
ALh84Oe0/kymyE2mi8AdSAxGcVZZqdiWcyFQjb5IqzOg/jieXHc96DXrShGnDopZrpijXU9A/vLb
qjb61trlm3V26fZkXEodU6LnDhCH4lttx63KCGpY8w2WGBaCGoWkNL1+PjdOqnvErdri+nYA+IW5
OVm47McgBMMPJt0yfg==
--00000000000011331e05edb9ac94--
