Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638056C66C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 05:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiGIDfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 23:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIDfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 23:35:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF297CB4B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 20:35:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so669158wrx.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYUvSrUcJo4H9s2N0GzmP2gQ316nJBasvQNNovhT8c4=;
        b=Bln8lRhc3tP57Dj7odkC/0roBKy/ObQ3FL6cQ766pZUgVJGTK7oZpqsfoEUWuk5Uoj
         KX6C5mLH4Kdbuc0yYEDDVyXYz1pv3nQyCHA5bTfXxq/X3XFbsgQ2uB2xG2T0Gwdoy/P+
         QfBzXZg48CLe3qnyzDRSisURDBfDjclUhQuhDbRlCfrVerc0jJ+UGcrF36CkAsFFHY6C
         yJmm1Av/u/dGOlu98utOs9gUr2vo3pxc4U53utWAwmORfjAshOr5Vc8tiv1knZz+BPIR
         /sZ9tosc7BUpj/W9FAkj/K7bIHDpWygU54yfQbp1yTQt6qZtIvXHCs2ZreWRheLoyyBu
         YQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYUvSrUcJo4H9s2N0GzmP2gQ316nJBasvQNNovhT8c4=;
        b=qJ6XL1ZE2bfFk4ePt4R7UD2i3Znp8WuXYOQHL6cP5Z+bt+MMUYgFjBMCwyjtFsnOgE
         N+ht+NYhwkBTiUqKGSprx6A/3m0/ocdarGM+grHJL62s3MD04p+NlRS0zvFJrkMmT+4Z
         i51OJcy8dESnYS6u5BDhXB0cnlt89GGzf+usOi8pRrkvCuElkegva8qnGIjO8Mz6QdVm
         MOvsgAp7Hwh/qkNiz/zMbDsStSv0SZX4QiSF5KWdhotvGGgKsFnByX49NqWx5FHbbKpy
         WVj7htkhDh54VC+Ypf6yqiLZLDI0G7zP7cx16MfcMXQ3LqhJNTV4tU6/QNSF3YlIiblz
         aF4g==
X-Gm-Message-State: AJIora9vBKa5Rz1RKXuNfYaGH6dNee1y1d9kVn30Dg+uFC56jPe75HZc
        014qks7+Y7vfQOAacxq2izak7Zp+UJq+0DquRlCKjg==
X-Google-Smtp-Source: AGRyM1shMGyZogpGCQ7rR8WEcQtWqL8IiGW2YMygvlDEPhuGrGBQS1ciC9jpCUsZGsmLEfDWmVRI67mLR1of4gEOnKo=
X-Received: by 2002:adf:e804:0:b0:21d:6e85:7550 with SMTP id
 o4-20020adfe804000000b0021d6e857550mr6400492wrm.337.1657337738375; Fri, 08
 Jul 2022 20:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220708044847.531566-1-davidgow@google.com> <20220708044847.531566-3-davidgow@google.com>
 <fc638852-ac9a-abab-8fdb-01b685cdec96@linuxfoundation.org>
 <CAGS_qxpODhSEs_sMm5Gu55EsYy-M9V98eLU-8O+xGMxncXmY4A@mail.gmail.com>
 <f25f96ce-1c9b-7e66-a5be-96d7cf2988cf@linuxfoundation.org> <a00efaa8-71e0-c531-b6a4-e3d695ad628b@linuxfoundation.org>
In-Reply-To: <a00efaa8-71e0-c531-b6a4-e3d695ad628b@linuxfoundation.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 9 Jul 2022 11:35:27 +0800
Message-ID: <CABVgOSkroVjxTDoKTLBxiX_Fw5qZQmchDpY4U3XCCRYfXbS2bQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] kunit: Taint the kernel when KUnit tests are run
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f319b05e3570393"
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

--0000000000002f319b05e3570393
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 9, 2022 at 5:24 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/8/22 3:22 PM, Shuah Khan wrote:
> > On 7/8/22 3:00 PM, Daniel Latypov wrote:
> >> On Fri, Jul 8, 2022 at 1:22 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>>
> >>> On 7/7/22 10:48 PM, David Gow wrote:
> >>>> Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> >>>> Due to KUnit tests not being intended to run on production systems, and
> >>>> potentially causing problems (or security issues like leaking kernel
> >>>> addresses), the kernel's state should not be considered safe for
> >>>> production use after KUnit tests are run.
> >>>>
> >>>> This both marks KUnit modules as test modules using MODULE_INFO() and
> >>>> manually taints the kernel when tests are run (which catches builtin
> >>>> tests).
> >>>>
> >>>> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> >>>> Tested-by: Daniel Latypov <dlatypov@google.com>
> >>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >>>> Signed-off-by: David Gow <davidgow@google.com>
> >>>> ---
> >>>>
> >>>> No changes since v5:
> >>>> https://lore.kernel.org/linux-kselftest/20220702040959.3232874-3-davidgow@google.com/
> >>>>
> >>>> No changes since v4:
> >>>> https://lore.kernel.org/linux-kselftest/20220701084744.3002019-3-davidgow@google.com/
> >>>>
> >>>
> >>> David, Brendan, Andrew,
> >>>
> >>> Just confirming the status of these patches. I applied v4 1/3 and v4 3/4
> >>> to linux-kselftest kunit for 5.20-rc1.
> >>> I am seeing v5 and v6 now. Andrew applied v5 looks like. Would you like
> >>> me to drop the two I applied? Do we have to refresh with v6?
> >>
> >> Just noting here that there'll be a merge conflict between this patch
> >> (3/4) and some other patches lined up to go through the kunit tree:
> >> https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/
> >>
> >> Not sure how we want to handle that.
> >>
> >
> > I can go drop the two patches and have Andrew carry the series through
> > mm tree.
> >
>
> Sorry spoke too soon. Yes there are others that might have conflicts as
> Daniel pointed out:
>
> https://patchwork.kernel.org/project/linux-kselftest/patch/20220625050838.1618469-2-davidgow@google.com/
>
> thanks,
> -- Shuah
>

Thanks everyone for pointing these out.

I've rebased the other series (the KUnit module support one:
https://lore.kernel.org/linux-kselftest/20220709032001.819487-1-davidgow@google.com/
) on top of this.

If they all go in via the kselftest/kunit tree, everything should be fine now.

Cheers,
-- David

--0000000000002f319b05e3570393
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDW
xOGRhc2KC7kyBAOO9VflVYWYSBCJ/Qfi9dyPQ2bzwzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MDkwMzM1MzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEADngLlw+7BHWsDfXodA5M
3ZhqcKoIUGTKOKpkyuCXDO2O0vKj8H+haMpVNzKb2bCYv1uGJ7wmYoCVGlEWyfEav54JNa7H0CId
0KmpuSkAFG0AmzSaowoyS6brF411oVsZfEorrGd+H/0v2p+yeF5McUzsBxW5J11rFRw/A/YNysqz
kHZkkNaZN8H46I3fYTGaNNVvYkbFJw3SXDO10Hbg6g1QLMHhcSF23AuLeaNoN1NN3vzLWIgkuq9n
SSxPm6THzbhMkmIXgPU0J1KeAuk4LmnWoLX0s3q4qWfaBTD8r4BYYa9yC7w/Ojx6KJTiM/kxZXtq
hAU+ejbbM2raoq4MZQ==
--0000000000002f319b05e3570393--
