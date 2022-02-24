Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DC4C2485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 08:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiBXHmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 02:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBXHmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:42:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28A2C659
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 23:41:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b5so609583wrr.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 23:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9pihpmmDqDBaJ+H0LXzxHZE/lZdUSBjFK4gVhwO1VM=;
        b=jEmX+PA0mXrM3XUG+rIxlB32wWHwCigPfKJ5rvQxSICYrYiQ8Uzqee5KM0XuH1RSqU
         CaG+9kOV46E3wVTbHYy8OY/Ffc/rxdK2rQSEjrZWSR2JFtAdN4+Czm/YKC1iATol/uhf
         PM3++bwRiuyoDCgmDb4YGHV+b6g4iOurhPhr5NaoH43GRM/F55ZsKgqP5S6PpzoVjHwa
         t09p5E3yicRifGpDUQtQunz4nF9ecjSN+nagN4/I2/BCFCm+3b01I5qNSobZWyniyfvz
         7XuyH4Ztzl9FIpHqpTAz6ql3f/t36bXgWUz32qGqHX+nSmxSiv0wn8CFEnL77wLvvSaZ
         mMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9pihpmmDqDBaJ+H0LXzxHZE/lZdUSBjFK4gVhwO1VM=;
        b=ZERA9VQW6vkB4dQBNyXTPfkVCo9Iz3PxdRfI7haGBhaN5BHb+jpENbbAB/khT3l9n3
         YS0tUmU4GGc3t/Sbg1RPa0ZmZ9IvZtTyjyeKw3OJh96AQ71PrUxj07407oDcFCW++A8I
         OubO0MCYm+LqQcVn6x7J3jqnRQGYWVjPpFyYUX0GcPlGvPkJsuvdBiGGrsqq9crVCutI
         CPP7keRaUCd31qBGD/x8w2QcBW9c95OksEJdqVC3MEkEP0YJXBy/pSCNaOVPoKp2iN2D
         ME8fXAT6LcS5p5SbxO2IpIj9DdsfAXssIjsHbKh8V2bDaLT1r01QAkrEKkQ82moMTWd5
         97og==
X-Gm-Message-State: AOAM5327Wla2wJ4U3LYuaXvjV7/mOd9SyUwxBTCgAOTUbBf+HwBKiBtv
        6tSYeIVxNw5VQ6pxKHmJVEjvHHdRlZGFuuUjeGCWtg==
X-Google-Smtp-Source: ABdhPJx0d6/ZjRGa7OYf534ii37zSpsDQoOflqiHsGvF7Gyg+PWAGgAdn4fmMa0TcYrDoACkdD1olf/rtI3kDYKWwUI=
X-Received: by 2002:adf:a486:0:b0:1ed:9cfe:179d with SMTP id
 g6-20020adfa486000000b001ed9cfe179dmr1177609wrb.113.1645688505599; Wed, 23
 Feb 2022 23:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
In-Reply-To: <20220224054332.1852813-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Feb 2022 15:41:34 +0800
Message-ID: <CABVgOSn97OaW9j_NOqc4KS5BzvF0D7_yvpOT+XVK0vHW2F+FNw@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ced41505d8beb6ad"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ced41505d8beb6ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 1:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Adds simple KUnit test for some binfmt_elf internals: specifically a
> regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> fix overflow in total mapping size calculation").
>

(Just as a note to anyone else testing this, this hasn't hit
linux-next yet, so the test does fail out of the box.)

> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: "Magnus Gro=C3=9F" <magnus.gross@rwth-aachen.de>
> Cc: kunit-dev@googlegroups.com
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

This looks like a pretty sensible test to me. It's definitely doing a
few weird things with the whole COMPAT support bit, and I do think
that inverting the flow and having the binfmt_elf_test.c file include
binfmt_elf.c is probably the more flexible solution.

In any case, the test works well for me (including the compat_
variant), modulo a build error and needing to apply the aforementioned
fix first.

Cheers,
-- David

> I'm exploring ways to mock copy_to_user() for more tests in here.
> kprobes doesn't seem to let me easily hijack a function...

Not much to add to what Daniel said here, other than to re-tread some
old discussions around using ftrace, weak-linked symbols, and all
sorts of other horrors to intercept function calls.

The least horrifying solution we've thought of thus far is to
literally change the function to add a test to see if it's running
under a KUnit test which wants to mock it out (using the pointer in
task_struct and KUnit named resources to check). Even then, that's
definitely the sort of thing that you want behind an #ifdef
CONFIG_KUNIT check, and even then is likely to be met with some
disapproval for something as performance-sensitive as copy_to_user().
Of course, if just including the binfmt_elf.c file from within the
test file and using #defines works -- i.e., we don't need to care
about very indirect calls from within different files -- then that's
the simplest solution.

More binfmt_elf tests would be great, though, particularly if we can
get some of those nasty parsing functions tested.

> ---
>  fs/Kconfig.binfmt      | 17 +++++++++++
>  fs/binfmt_elf.c        |  4 +++
>  fs/binfmt_elf_test.c   | 64 ++++++++++++++++++++++++++++++++++++++++++
>  fs/compat_binfmt_elf.c |  2 ++
>  4 files changed, 87 insertions(+)
>  create mode 100644 fs/binfmt_elf_test.c
>
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 4d5ae61580aa..8e14589ee9cc 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -28,6 +28,23 @@ config BINFMT_ELF
>           ld.so (check the file <file:Documentation/Changes> for location=
 and
>           latest version).
>
> +config BINFMT_ELF_KUNIT_TEST
> +       bool "Build KUnit tests for ELF binary support" if !KUNIT_ALL_TES=
TS
> +       depends on KUNIT=3Dy && BINFMT_ELF=3Dy
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the ELF loader KUnit tests.
> +
> +         KUnit tests run during boot and output the results to the debug=
 log
> +         in TAP format (https://testanything.org/). Only useful for kern=
el devs
> +         running KUnit test harness and are not for inclusion into a
> +         production build.

It might be worth documenting here that this particular config option
actually builds two test suites if COMPAT is enabled.

> +
> +         For more information on KUnit and unit tests in general please =
refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config COMPAT_BINFMT_ELF
>         def_bool y
>         depends on COMPAT && BINFMT_ELF
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 76ff2af15ba5..9bea703ed1c2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2335,3 +2335,7 @@ static void __exit exit_elf_binfmt(void)
>  core_initcall(init_elf_binfmt);
>  module_exit(exit_elf_binfmt);
>  MODULE_LICENSE("GPL");
> +
> +#ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
> +#include "binfmt_elf_test.c"
> +#endif
> diff --git a/fs/binfmt_elf_test.c b/fs/binfmt_elf_test.c
> new file mode 100644
> index 000000000000..486ad419f763
> --- /dev/null
> +++ b/fs/binfmt_elf_test.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <kunit/test.h>
> +
> +static void total_mapping_size_test(struct kunit *test)
> +{
> +       struct elf_phdr empty[] =3D {
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0, .p_memsz =3D 0, },
> +               { .p_type =3D PT_INTERP, .p_vaddr =3D 10, .p_memsz =3D 99=
9999, },
> +       };
> +       /*
> +        * readelf -lW /bin/mount | grep '^  .*0x0' | awk '{print "\t\t{ =
.p_type =3D PT_" \
> +        *                              $1 ", .p_vaddr =3D " $3 ", .p_mem=
sz =3D " $6 ", },"}'
> +        */
> +       struct elf_phdr mount[] =3D {
> +               { .p_type =3D PT_PHDR, .p_vaddr =3D 0x00000040, .p_memsz =
=3D 0x0002d8, },
> +               { .p_type =3D PT_INTERP, .p_vaddr =3D 0x00000318, .p_mems=
z =3D 0x00001c, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00000000, .p_memsz =
=3D 0x0033a8, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00004000, .p_memsz =
=3D 0x005c91, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000a000, .p_memsz =
=3D 0x0022f8, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000d330, .p_memsz =
=3D 0x000d40, },
> +               { .p_type =3D PT_DYNAMIC, .p_vaddr =3D 0x0000d928, .p_mem=
sz =3D 0x000200, },
> +               { .p_type =3D PT_NOTE, .p_vaddr =3D 0x00000338, .p_memsz =
=3D 0x000030, },
> +               { .p_type =3D PT_NOTE, .p_vaddr =3D 0x00000368, .p_memsz =
=3D 0x000044, },
> +               { .p_type =3D PT_GNU_PROPERTY, .p_vaddr =3D 0x00000338, .=
p_memsz =3D 0x000030, },
> +               { .p_type =3D PT_GNU_EH_FRAME, .p_vaddr =3D 0x0000b490, .=
p_memsz =3D 0x0001ec, },
> +               { .p_type =3D PT_GNU_STACK, .p_vaddr =3D 0x00000000, .p_m=
emsz =3D 0x000000, },
> +               { .p_type =3D PT_GNU_RELRO, .p_vaddr =3D 0x0000d330, .p_m=
emsz =3D 0x000cd0, },

This doesn't build for me, as PT_GNU_RELRO isn't defined. Adding it
makes the test build:

---
Signed-off-by: David Gow <davidgow@google.com>
---
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..c33cdb4d9464 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -36,6 +36,7 @@ typedef __s64 Elf64_Sxword;
#define PT_LOPROC  0x70000000
#define PT_HIPROC  0x7fffffff
#define PT_GNU_EH_FRAME                0x6474e550
+#define PT_GNU_RELRO           0x6474e552
#define PT_GNU_PROPERTY                0x6474e553

#define PT_GNU_STACK   (PT_LOOS + 0x474e551)
---

> +       };
> +       size_t mount_size =3D 0xE070;
> +       /* https://lore.kernel.org/lkml/YfF18Dy85mCntXrx@fractal.localdom=
ain */
> +       struct elf_phdr unordered[] =3D {
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00000000, .p_memsz =
=3D 0x0033a8, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000d330, .p_memsz =
=3D 0x000d40, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x00004000, .p_memsz =
=3D 0x005c91, },
> +               { .p_type =3D PT_LOAD, .p_vaddr =3D 0x0000a000, .p_memsz =
=3D 0x0022f8, },
> +       };
> +
> +       /* No headers, no size. */
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(NULL, 0), 0);
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 0), 0);
> +       /* Empty headers, no size. */
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 1), 0);
> +       /* No PT_LOAD headers, no size. */
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(&empty[1], 1), 0);
> +       /* Empty PT_LOAD and non-PT_LOAD headers, no size. */
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(empty, 2), 0);
> +
> +       /* Normal set of PT_LOADS, and expected size. */
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(mount, ARRAY_SIZE(mount)=
), mount_size);
> +       /* Unordered PT_LOADs result in same size. */
> +       KUNIT_EXPECT_EQ(test, total_mapping_size(unordered, ARRAY_SIZE(un=
ordered)), mount_size);
> +}
> +
> +static struct kunit_case binfmt_elf_test_cases[] =3D {
> +       KUNIT_CASE(total_mapping_size_test),
> +       {},
> +};
> +
> +static struct kunit_suite binfmt_elf_test_suite =3D {
> +       .name =3D KBUILD_MODNAME,
> +       .test_cases =3D binfmt_elf_test_cases,
> +};
> +
> +kunit_test_suite(binfmt_elf_test_suite);
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index 95e72d271b95..8f0af4f62631 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -135,6 +135,8 @@
>  #define elf_format             compat_elf_format
>  #define init_elf_binfmt                init_compat_elf_binfmt
>  #define exit_elf_binfmt                exit_compat_elf_binfmt
> +#define binfmt_elf_test_cases  compat_binfmt_elf_test_cases
> +#define binfmt_elf_test_suite  compat_binfmt_elf_test_suite
>
>  /*
>   * We share all the actual code with the native (64-bit) version.
> --
> 2.30.2
>

--000000000000ced41505d8beb6ad
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAFB5XJs46lHhs45dlgv
lPcwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjAyMDcy
MDA0MDZaFw0yMjA4MDYyMDA0MDZaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0RBy/38QAswohnM4+BbSvCjgfqx6l
RZ05OpnPrwqbR8foYkoeQ8fvsoU+MkOAQlzaA5IaeOc6NZYDYl7PyNLLSdnRwaXUkHOJIn09IeqE
9aKAoxWV8wiieIh3izFAHR+qm0hdG+Uet3mU85dzScP5UtFgctSEIH6Ay6pa5E2gdPEtO5frCOq2
PpOgBNfXVa5nZZzgWOqtL44txbQw/IsOJ9VEC8Y+4+HtMIsnAtHem5wcQJ+MqKWZ0okg/wYl/PUj
uaq2nM/5+Waq7BlBh+Wh4NoHIJbHHeGzAxeBcOU/2zPbSHpAcZ4WtpAKGvp67PlRYKSFXZvbORQz
LdciYl8fAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKbSiBVQ
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB8
Mr6BJb4BYxVfeVVDisbL0OQ42VgZ+E7+jRSx9E3i+jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjQwNzQxNDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAabDLwRIGBdSIRSKpjO5m
JCFkXr6fyIXJGEib0DoxTa5YLyTQ/kcEYc+STg7TTW1O77rOMH2d1Qo/5LdoKAtrpzIDv9nEvSdI
dWNUIunk3/BzQl9+BE6SknDEVqG6hdc8fO7Xg5KMHjKS9dKPhp+FhLYUZPMnAqXeDWqselUHukDs
JoMWjbDaLBhAK/MlaNAX5cjp92KZ6eQLV56365Iw/tsv0mfijb9i47uYCBT7LN1rx1cF03d394gf
foIL64rqB8VepTHp+ZF/LsYGQ6Fynxn8VEODo2b6/9kzAaMY4jdecbmYW9fDKCy9MmgvRUfzYhbs
7NEytb3RKebICMlLwQ==
--000000000000ced41505d8beb6ad--
