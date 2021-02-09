Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3C3147F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 06:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBIFNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 00:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBIFNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:13:11 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3AC061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 21:12:31 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id q85so4623606qke.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 21:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zuv5/9akWxU8uZwWJlqi27qeqjCsmabo9tQhLSnobyI=;
        b=hmvhTFDCdcMPrDKjMVqWzx1Dn6b+xg8pFoZ8PAjHR2H1xyW8JeD2lifowaebZ80Yuk
         In8oQq6ZmxlrjlqWJMyPFCsgQNtMsLLvQ1uIUpFzGif8Qeo+zCJmp7NGb9QnXYMH+Ghz
         Jy85fPKwYgdQiZI/47x36uOaFttFO1J1FUO5kmMzQBzIUXCZCNy6/2TU/3MwvKEMEOKU
         b/Yv+FtxEipXmNHjoYnNNnuJI/QMraILQsitgJKQnI3HxRZvRoewWpCR8KNGIoSrZR0h
         Tdfa2xnym60pZKLSUOi329BHdCQTh0XxfC2QjBHyHBVG8aglzvLGvNmR0IJ4DvfNU4ls
         om7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zuv5/9akWxU8uZwWJlqi27qeqjCsmabo9tQhLSnobyI=;
        b=emz+S7fze4ZYZfbsUsXitfPClNO8X/6T2EMnhkg0cDuGCbktS151ANWe34kyUZF6Ej
         r/oVDR3Nv8qKdxR+Odm9c3sFlX3vrMOls+mQeAXXnPu2MVEff7VaO1iJ4CF08zjjFi+e
         2HJ6+qo9J20IWn5NX5jMES3D1NzbaiyMVp4b1UlicJAJkXPl6wwAEh6DyF1bQxA0zuN4
         ng2vdjR0chJkeaIIina22yIx7RCKnHIOg8jp5pzO+pTnK038vUTZsEyYLM3Tp9XXZtON
         TbSerpNbK6ag84CjTcJsqF7BnAsSSvheoM30AHM3Gk8wDZTRrHfJvaTuP9qjAmMrhQvc
         kMkQ==
X-Gm-Message-State: AOAM532NKwTvpzV+1fSj26JZIKFgNSZEHWu8f0B7MzKfKc1GvINKj1gu
        t3QNXUtnOEk06urGEsSU5oZ9+L0bmpqR5yhtAg7WOvBt/Lorgnjl
X-Google-Smtp-Source: ABdhPJw6TPBlsJRqqPFkTPLMz/Hjl7SQy/uZ6LN3uLTV69msgVeCJBrtXndWsUSrjgBQmDO9UaD9JJcLQ1d/ZGNLE1I=
X-Received: by 2002:a37:c01:: with SMTP id 1mr8765464qkm.493.1612847549921;
 Mon, 08 Feb 2021 21:12:29 -0800 (PST)
MIME-Version: 1.0
References: <87lfcne59g.fsf@collabora.com> <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com> <YBM6gAB5c2zZZsx1@mit.edu> <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu> <87wnvi8ke2.fsf@collabora.com> <20210208221916.GN4626@dread.disaster.area>
 <YCHgkReD1waTItKm@mit.edu>
In-Reply-To: <YCHgkReD1waTItKm@mit.edu>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Mon, 8 Feb 2021 21:12:17 -0800
Message-ID: <CACGdZYKFF8eQ7qzqE3=F4v+ZnNHMpO8QY=pmnYzPMe6m2So-Wg@mail.gmail.com>
Subject: Re: [RFC] Filesystem error notifications proposal
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        jack@suse.com, Al Viro <viro@zeniv.linux.org.uk>,
        amir73il@gmail.com, dhowells@redhat.com, darrick.wong@oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000052159705bae055a7"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000052159705bae055a7
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 8, 2021 at 5:08 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 09, 2021 at 09:19:16AM +1100, Dave Chinner wrote:
> > Nope, not convinced at all. As a generic interface, it cannot be
> > designed explicitly for the needs of a single filesystem, especially
> > when there are other filesystems needing to implement similar
> > functionality.
> >
> > As Amir pointed up earlier in the thread, XFS already already has
> > extensive per-object verification and error reporting facilicities...
>
> Sure, but asking Collabora to design something which works for XFS and
> not for ext4 is also not fair.
>
> If we can't design something that makes XFS happy, maybe it will be
> better to design something specific for ext4.  Alternatively, perhaps
> the only thing that can be made generic is to avoid scope creep, and
> just design something which allows telling userspace "something is
> wrong with the file system", and leaving it at that.

It sounds like the two asks are pretty compatible, and we are
interested I think in some sort of generic reporting infra, rather
than re-inventing it separately for ext4, xfs, etc. (e.g., we've found
ENOSPC useful to get notifications for in tmpfs, so on...)

ext4 mostly needs filesystem-wide notification, passing
variable-length data, without sleeping, allocs, or unsafe locks? XFS
additionally wants per-mount and per-inode scopes? So, something that
notifies per-fs, and leaves open the possibility for mount & inode
scopes for those filesystems that desire it, w/ a generic "message"
format seems like the way to go? watch_queue or similar seems nice due
to not allocating. The seeming 128 byte limit per message though seems
too short if we want to be able to send strings or lots of metadata,
an alternative format with larger maximums seems necessary. (IMO this
is preferable to chaining 128 bytes notifications w/ 48 byte headers
each)

What to include in the "generic" header then becomes a hot topic... To
my naive eyes the suggested 6 fields don't seem outrageous, but an
alternative though could be just, it's all filesystem specific info,
leaving the only generic fields to be message type/version/length.
Since, regardless of the data you send, you can use the same generic
interface for hooking and preparing/sending the message. A fully
featured monitoring system would want to peek into per-fs data anyhow,
I'd think.

>
> But asking Collabora to design something for XFS, but doesn't work for
> ext4, is an absolute non-starter.
>
> > If we've already got largely standardised, efficient mechanisms for
> > doing all of this in a filesystem, then why would we want to throw
> > that all away when implementing a generic userspace notification
> > channel?
>
> You don't.  And if you want to implement something that works
> perfectly for xfs, but doesn't work for ext4, feel free.
>
> Cheers,
>
>                                         - Ted

--00000000000052159705bae055a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmAYJKoZIhvcNAQcCoIIPiTCCD4UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzyMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
MEvaI7F4ZN2DM20wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAIKZMQsUIWBTlSa6tHLU5L8W
YVOXfTkEXU6aeq8JjYjcj1fQD+1K0EQhvwz6SB5I0NhqfMLyQBUZHJXChsLGygbCqXbmBF143+sK
xsY5En+KQ03HHHn8pmLHFMAgvO2f8cJyJD3cBi8nMNRia/ZMy2jayQPOiiK34RpcoyXr80KWUZQh
iqPea7dSkHy8G0Vjeo4vj+RQBse+NKpyEzJilDUVpd5x307jeFjYBp2fLWt0UAZ8P2nUeSPjC2fF
kGXeiYWeVPpQCSzowcRluUVFrKApZDZpm3Ly7a5pMVFQ23m2Waaup/DHnJkgxlRQRbcxDhqLKrJj
tATPzBYapBLXne4xggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAH+
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBbFXEtGqnv1
xDyY/+W2VSBjn0h/upXtjMyro+kxTRHIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDIwOTA1MTIzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAodUKVc2LpIoWcjSIHMVMEr5FAv7u9
rzQhcFxEqGgcFlUMovLeYER68YyDIYQaG/XDeJ4hYwQH5YVvTZtRQwFqp2udO99R7GW0lzoqpKYQ
uJyxRZTUXtZGxCf0D63QVIJFnPHvOvKqu5xmhjLYo/KdK9eytl1J3xqOzRZOJobC7U6dFYAwhpW+
frrWeifyCVlnG+UT4yltSms8KSbaukhN+FLly5H+UtHSqC+03PLWVuz4zT6rwwDFeOX3DSqldFjm
GalMG0FDwEB1kkJuIw9Kw2G87JNxYjnVzqLl87bBgM1KuX7n3rJGuABa1wz+vUkhSn8wRIOzO6Qa
xjdzZN0k
--00000000000052159705bae055a7--
