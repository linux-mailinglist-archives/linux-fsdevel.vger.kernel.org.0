Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5097150ABEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442210AbiDUXWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442540AbiDUXWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:22:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14510E0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 16:19:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so5894983pgn.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63PsHn0t/NdeUnwsv3HAPsKxG9T/V7/LpqCP68enOiU=;
        b=mt8XpRHBc5sB6gVw6G7OCCmFM0iS+TFXFhPU4sRKKK2LJqZ5m9W21+K5D7lhSQOeBP
         BG0dSA7yEbE+yKV4jiJ36o4aEM4CjPpUGmi9bh4muhn3H4WEEhPVULIURWwCIlCzUimP
         vYGoJTrZmaC9k9dQvKtTEmz3y9fzePrbfSMmdvPqu+kU/tdxf+pSXc2KKvI8tRgN15hR
         7Skwim2lxipcpXHJylfosumhyUrL78S4sybxTIFHF60azBs6vAi2bCU44IVgucNZiIcS
         lnIoK17DIwgvNEfpF9M3+0d2Na9Ncf7yqhsF5CVV17/W04+V2wb/Yee6pfuDIS9uPlz3
         xh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63PsHn0t/NdeUnwsv3HAPsKxG9T/V7/LpqCP68enOiU=;
        b=PMIbPQB/BbBjgv7lpQ0X88VCXcYaum2R9DvpwVebgMpAhCGsqWcBOOLKGSuTv536Gz
         Uwo7vL+kkpJ5Q2QtFN00qERUo7m5SPKedpZSp1Viz/fAxvRfMESbfsoviZi5fRlAGlDG
         AfGYYFfr1D6KfCwRc/dlyBqjN4xuy7A9frmnfpYd3Eg0ist5utHEsxBmb3ya46F0g4FP
         sQWTm+Fo4cOU+hRpypTBfumXbf8zNodLrL9Thl9bqAt8D487MBFM+cHNOW4jRLCTgvf/
         ZzSCS+4Scq305N6/lcXg+/WsDIRp4zKqfMWVADt64uyupy2bD4lWujs/MGnjB/9+xkvn
         RMkw==
X-Gm-Message-State: AOAM530zc1XQRvbBRHJ75zrTXhu9TCeLiuHp1F0TGH//3thVIdSy4cbO
        4oVHLwsAQZ4iz3E7VUNVCpVyOYdjSaR4dFuuWDN1cVGKp911lw==
X-Google-Smtp-Source: ABdhPJzsRjq1S9Qj46NM8thCKP+fXqaYcHpI9JfMkCThthhnw4KtyFgelRLVQaMvYpgJkP4RTOpuBMgKhTCmAn2yWzE=
X-Received: by 2002:a63:2305:0:b0:39d:1299:29c9 with SMTP id
 j5-20020a632305000000b0039d129929c9mr1526233pgj.244.1650583193262; Thu, 21
 Apr 2022 16:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220418213713.273050-1-krisman@collabora.com>
 <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
 <87h76pay87.fsf@collabora.com> <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Thu, 21 Apr 2022 16:19:41 -0700
Message-ID: <CACGdZY+KqPKaW3jM2SN4MA8_SUHSRiA2Dt43Q7NbK7BO2t_FVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f145e205dd32585d"
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

--000000000000f145e205dd32585d
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 20, 2022 at 10:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Apr 19, 2022 at 6:29 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Andrew Morton <akpm@linux-foundation.org> writes:
> >
> > Hi Andrew,
> >
> > > On Mon, 18 Apr 2022 17:37:10 -0400 Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> > >
> > >> When provisioning containerized applications, multiple very small tmpfs
> > >
> > > "files"?
> >
> > Actually, filesystems.  In cloud environments, we have several small
> > tmpfs associated with containerized tasks.
> >
> > >> are used, for which one cannot always predict the proper file system
> > >> size ahead of time.  We want to be able to reliably monitor filesystems
> > >> for ENOSPC errors, without depending on the application being executed
> > >> reporting the ENOSPC after a failure.
> > >
> > > Well that sucks.  We need a kernel-side workaround for applications
> > > that fail to check and report storage errors?
> > >
> > > We could do this for every syscall in the kernel.  What's special about
> > > tmpfs in this regard?
> > >
> > > Please provide additional justification and usage examples for such an
> > > extraordinary thing.
> >
> > For a cloud provider deploying containerized applications, they might
> > not control the application, so patching userspace wouldn't be a
> > solution.  More importantly - and why this is shmem specific -
> > they want to differentiate between a user getting ENOSPC due to
> > insufficiently provisioned fs size, vs. due to running out of memory in
> > a container, both of which return ENOSPC to the process.
> >
>
> Isn't there already a per memcg OOM handler that could be used by
> orchestrator to detect the latter?
>
> > A system administrator can then use this feature to monitor a fleet of
> > containerized applications in a uniform way, detect provisioning issues
> > caused by different reasons and address the deployment.
> >
> > I originally submitted this as a new fanotify event, but given the
> > specificity of shmem, Amir suggested the interface I'm implementing
> > here.  We've raised this discussion originally here:
> >
> > https://lore.kernel.org/linux-mm/CACGdZYLLCqzS4VLUHvzYG=rX3SEJaG7Vbs8_Wb_iUVSvXsqkxA@mail.gmail.com/
> >
>
> To put things in context, the points I was trying to make in this
> discussion are:
>
> 1. Why isn't monitoring with statfs() a sufficient solution? and more
>     specifically, the shared disk space provisioning problem does not sound
>     very tmpfs specific to me.
>     It is a well known issue for thin provisioned storage in environments
>     with shared resources as the ones that you describe

I think this solves a different problem: to my understanding statfs
polling is useful for determining if a long lived, slowly growing FS
is approaching its limits - the tmpfs here are generally short lived,
and may be intentionally running close to limits (e.g. if they "know"
exactly how much they need, and don't expect to write any more than
that). In this case, the limits are there to guard against runaway
(and assist with scheduling), so "monitor and increase limits
periodically" isn't appropriate.

It's meant just to make it easier to distinguish between "tmpfs write
failed due to OOM" and "tmpfs write failed because you exceeded tmpfs'
max size" (what makes tmpfs "special" is that tmpfs, for good reason,
returns ENOSPC for both of these situations to the user). For a small
task a user could easily go from 0% to full, or OOM, rather quickly,
so statfs polling would likely miss the event. The orchestrator can,
when the task fails, easily (and reliably) look at this statistic to
determine if a user exceeded the tmpfs limit.

(I do see the parallel here to thin provisioned storage - "exceeded
your individual budget" vs. "underlying overcommitted system ran out
of bytes")

> 2. OTOH, exporting internal fs stats via /sys/fs for debugging, health
> monitoring
>     or whatever seems legit to me and is widely practiced by other fs, so
>     exposing those tmpfs stats as this patch set is doing seems fine to me.
>
> Another point worth considering in favor of /sys/fs/tmpfs -
> since tmpfs is FS_USERNS_MOUNT, the ability of sysadmin to monitor all
> tmpfs mounts in the system and their usage is limited.
>
> Therefore, having a central way to enumerate all tmpfs instances in the system
> like blockdev fs instances and like fuse fs instances, does not sound
> like a terrible
> idea in general.
>
> > > Whatever that action is, I see no user-facing documentation which
> > > guides the user info how to take advantage of this?
> >
> > I can follow up with a new version with documentation, if we agree this
> > feature makes sense.
> >
>
> Given the time of year and participants involved, shall we continue
> this discussion
> in LSFMM?
>
> I am not sure if this even requires a shared FS/MM session, but I
> don't mind trying
> to allocate a shared FS/MM slot if Andrew and MM guys are interested
> to take part
> in the discussion.
>
> As long as memcg is able to report OOM to the orchestrator, the problem does not
> sound very tmpfs specific to me.
>
> As Ted explained, cloud providers (for some reason) charge by disk size and not
> by disk usage, so also for non-tmpfs, online growing the fs on demand could
> prove to be a rewarding practice for cloud applications.
>
> Thanks,
> Amir.

--000000000000f145e205dd32585d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
h3dPtFviTyG11HYwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAE0ANr7NUOqEcZce4KYP
SjzlrshSC8sgJ8dKDDbe35PL86vDuMIrytVjiV10p/YUofun9GeHBY6r5kTyh4be5FgftiiNtWzn
U1W5cxLYMT1hKYxXxnM2sWMQGFl4TkxxbRoVZa3ou/NxFdAZeiQSwGnzk5oIDTBZQc8q3wMa1svm
A5Rd4MVaIUt+hyk6seAldN6k4/O34O1l2V6D+/BwagyzLWvOeMEM9hClVF+F6a20yy4dcDsprFZZ
Sk9JzUy9F6FM7L1wT2ndjTNDja4Y2tixf31KuisZLGKmDZsW/fXF1GgWDaM0DbYJwtE3kHylWnMk
CN4PfYgIa15C5A9lXhExggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAFEftjde/YEIFcjUXqhcBUwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKH2SLVd
DVsfK9YoXkRmgP0aTgtxENd/WJeJX+o12YfgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDQyMTIzMTk1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMiHeNPGqgL3vyHR5A52udBAmS
grtTQU4GIcqAaoE+3Oz4XzSmyCn5vxoJhNcW0JgEwLnMqRQ3SDK9x6HBY7PDvB4wtw+q394d6KnJ
Uc7gcoVi6Nc6bA/MpePAG0NWs5f9s7Fe/tMD4VQUzD84HG/8YLc0wdptg2pXLWdO4KCo8gNqBZht
6uufNtIyfxhAf7FPzK89GuHgxVU7Espo6qfRmuKTp4+ya06O0/r1WWZ9julrBcJlVfNIX1/dGjXP
JRi/dJ9EvA1Y0yCzpkNmqf3fyARiNb1ysySbAx19rJ3wAxQQQIjL0czf96gvUGI73sm/mPkMr5th
piRjF9Vwzu2L
--000000000000f145e205dd32585d--
