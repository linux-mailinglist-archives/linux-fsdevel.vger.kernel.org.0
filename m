Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2451D1D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387718AbiEFHFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 03:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387628AbiEFHF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 03:05:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9E50050
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 00:01:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg25so3860709wmb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 00:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGTiQdFZir3JGg77TIFAFhu2mng/V1wuD90wZvDc+Cw=;
        b=sJeHYED/BphVruQjBElxG+HxeepzGbxyw8mZnY4hNw4jnTn8jLAprTHBRqeBVEvbjC
         RXEqMnpd6iObosOVLnHhVk7Q/uAOx0OlwMGufnMUcNDJ1n/gy61gO1si1Zjn3ijFPSTm
         WNbkqlWpE0+JPWT14Ct9GawZ3bRW4TuTkWMzPxxyNtD85KJ8DOE4RP+dNanNxW504fPd
         dCNXfbnBLiIpugC6l6KsU0af8eU/iVALjkvAFAKADzy0WYzBqUCv8V6Kials/fvdNMWL
         wr8S2FxsqNuuuizZXevxSSLo1VJ2tVB2Q+boGGWsqmzv+lzHzLLkc7FaMK8AysX0nFmK
         ldcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGTiQdFZir3JGg77TIFAFhu2mng/V1wuD90wZvDc+Cw=;
        b=bEL0Dw8kxf1AXYqCvTOysNgpZY7PSm1kK4tyKqvop+M8m8MGfdUlnhWGIdb4yH0jan
         y1N1hvaNrfTGxn7rCTc/qaJ4aH5TmstvQOXfA4fiq9Osbz4A4PxqMQ3UAXZs7RuVC4BW
         rydTZ8veZ7m7bDsd2UWkie6CTSoqpAdVgW/N0DVjYjtGt7Vq093Lg53cJ5RUys2AO09x
         /zs6Ryuy/ySkFst15a+PRaxNeIEZVIb7euLKkQ/9aOCnz39jtUQNKbgXhxuqJa5N9XEA
         NQJFRFdSaMHYdgyppYFeUxkzIRPFLlLoaWeMCbhjxQcNFL/XMYHM0zrMtO1DAmSnvw49
         UCgA==
X-Gm-Message-State: AOAM530PHQ8p6zPDFQE+bSPUjpn0G5xUgcVvAiuxAI5Hbbix2+fmi13c
        jtFVveFAItNUMXZAAr8Xedtp5ic2aTdBXfDNVRzGZw==
X-Google-Smtp-Source: ABdhPJxgiYvcpDl5iIQO0WW2jhx5CW4NvSGAj1yQeUK6OqNF1Z6M/1hngPglCSRdiQp6dzFREoSS6qG4PV+b5nu2+X0=
X-Received: by 2002:a05:600c:12c9:b0:394:54ab:52c5 with SMTP id
 v9-20020a05600c12c900b0039454ab52c5mr8566186wmd.141.1651820505351; Fri, 06
 May 2022 00:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220430030019.803481-1-davidgow@google.com>
 <Ym7P7mCoMiQq99EM@bombadil.infradead.org> <Ym7QXOMK3fLQ+b6t@bombadil.infradead.org>
 <CABVgOSmXyN3SrDkUt4y_TaKPvEGVJgbuE3ycrVDa-Kt1NFGH7g@mail.gmail.com>
 <YnKS3MwNxvEi73OP@bombadil.infradead.org> <CAGS_qxrz1WoUd5oGa7p1-H2mQVbkRxSTEbqnCG=aBj=xnMu1zQ@mail.gmail.com>
 <YnLJ6dJQBTYjBRHZ@bombadil.infradead.org> <CAGS_qxoFECVJD3Jby1eTWG741hBWuotuEM78PU-qfyvp-nLV7Q@mail.gmail.com>
 <YnLsPgbQ7CHiannN@bombadil.infradead.org> <YnNnLIZDxkNwECv+@bombadil.infradead.org>
In-Reply-To: <YnNnLIZDxkNwECv+@bombadil.infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Fri, 6 May 2022 15:01:34 +0800
Message-ID: <CABVgOS=8=41KgVEgRAGcDZ_JrZpsVaK24ca0jR5J74XY9GCmDA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Taint kernel if any tests run
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000079b5a205de526e16"
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

--00000000000079b5a205de526e16
Content-Type: text/plain; charset="UTF-8"

On Thu, May 5, 2022 at 1:57 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 02:12:30PM -0700, Luis Chamberlain wrote:
> > On Wed, May 04, 2022 at 02:19:59PM -0500, Daniel Latypov wrote:
> > > On Wed, May 4, 2022 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > OK so, we can just skip tainting considerations for selftests which
> > > > don't use modules for now. There may be selftests which do wonky
> > > > things in userspace but indeed I agree the userspace taint would
> > > > be better for those but I don't think it may be worth bother
> > > > worrying about those at this point in time.
> > > >
> > > > But my point in that sharing a taint between kunit / selftests modules
> > > > does make sense and is easily possible. The unfortunate aspect is just
> > >
> > > Yes, I 100% agree that we should share a taint for kernelspace testing
> > > from both kunit/kselftest.
> > > Someone running the system won't care what framework was used.
> >
> > OK do you mind doing the nasty work of manually adding the new
> > MODULE_TAINT() to the selftests as part of your effort?
> >
> > *Alternatively*, if we *moved* all sefltests modules to a new
> > lib/debug/selftests/ directory or something like that then t would
> > seem modpost *could* add the taint flag automagically for us without
> > having to edit or require it on new drivers. We have similar type of
> > taint for staging, see add_staging_flag().
> >
> > I would *highly* prefer this approach, event though it is more work,
> > because I think this is a step we should take anyway.
> >
> > However, I just checked modules on lib/ and well, some of them are
> > already in their own directory, like lib/math/test_div64.c. So not
> > sure, maybe just move a few modules which are just in lib/*.c for now
> > and then just sprinkle the MODULE_TAINT() to the others?
>
> I *think* we could just pull this off with a much easier approach,
> simply looking for the substrings in the module name in modpost.c:
>
>   * "_test." || "-test."
>   * ^"test_" || ^"test-"
>
> An issue with this of course is a vendor $FOO with an out of tree
> test driver may end up with the taint. Perhaps we don't care.
>
> That means moving selftests to its own directory is not needed at this
> point in time.

I can't say I'm thrilled with the idea of just doing name comparisons,
particularly since not all of them match this pattern, for example:
bpf_testmod.ko. (Though, frankly, more of them do than I'd've
guessed.)

Maybe adding a taint call to the selftest helper module framework in
kselftest_module.h, though again, there are several tests which don't
use it.

I _suspect_ we'd be able to hit most of them by tainting in frameworks
like the above, and patch the remaining modules manually. There's also
definitely a grey area with things like netdevsim, which are used a
lot as helper modules by selftests, but may have other uses as well.

(The advantage of the KUnit tainting is that, due to KUnit's
centralised executor, we can be sure all KUnit tests will correctly
trigger the taint. But maybe it doesn't matter as much if one or two
selftests miss out.)

-- David

--00000000000079b5a205de526e16
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBr
X/PN1i5F2zIL242HU4GqsEFET+G6b/STy3yckg7VuTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA1MDYwNzAxNDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYDUZutewvAsTjHXMgVEQ
On7tpvC/sM+F49kXBC3mN+dn/xITeI7m47iTK6X+Ct5E9qGYkLDpN1d6LOUGC8DYAM0+YIfNNBn8
aHnuU6qetQUfkRDDhWw95HajkWpb477ny8XEnIUuALqDHB0K7RghabJhdBiA7q0GuVshOqNO6Bmt
lUV2xwQnDZ+SCkQ31O/icMGdFwY01JvvTx+XDR2jUHz2jOGAFR1ib96DuLG2sR6SASxR3MshuJsz
13a1zVVdu52JXd1CFyaLcqcyo9h0ykggX1NINTclSrw7EaQVP0Rziil/K422cAncptvuChRN5JCo
qugllBI5OPHAGbQmag==
--00000000000079b5a205de526e16--
