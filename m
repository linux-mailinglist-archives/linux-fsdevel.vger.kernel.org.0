Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3DFB5DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 18:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKMREE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 12:04:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38722 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKMRED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:04:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so2572527lfa.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ue0ID/EjSuwhaD2YneyBx29WXL6CWZKuZ5z+LHgXpJg=;
        b=nXo4MPMimiDbNQH6nt9QKyqzlNtrRIxXJBcHxAUys+WwtJroFlI/L45jpHvsebk6XF
         yOVY0/9kLoGlVYf2flnhoHHeNyUFee3GjnAoSxriM+YnqVd0i0IY3M9SXY79y0Qc5bl+
         4bfO7Y1K3AKuISea0tNmmUeNfK+t1mAYI7X4fgEJEnlpnS5RmLScLYiQ/eav1LzK4a5f
         utqsyoDqvxdMaPjNlTFrBMbtYPm3xllqkJmFKnchP/HIH9INUcw3rJh0JlJMMPw0iE7O
         9k9a44l8NUvpiJnAzBgrAqxPKFIeEBWDlVxe5LwCKINSMopuOgMBmeBsSfyDXFpf9OkD
         6wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ue0ID/EjSuwhaD2YneyBx29WXL6CWZKuZ5z+LHgXpJg=;
        b=rePWFO0s0uz288de8U/RRLrib3RSOONp/x1otg/vCVCxQ1XfJSyLmCWHC4uKfsOMpp
         AVzgyM/ggTMJCRpD9EGGsKXgxd1ZF54lYXFY86phPONY1JqHJ7ryvBo05w2xxXucNSus
         SOR6GM64VXpDbjzW+t+SDfvVEj9vYm8HEs6lPfo3WS0808nG/JFDR06iqF6sw97n5eTU
         +VVleouNx1+upqjyjYgdc8s7W7rtTvcG33sWsC0wAWueF5UimZoSv5Y7DRhe09ThAHJM
         5xm4bgcYOvWs310cq2xbKMgmjzJWLbbc3MH+Df0YpwGXn+gGvWHpG2w+ECFJhtem51Gm
         jVwg==
X-Gm-Message-State: APjAAAUUlUxAEzPthtH02lZmo8l7cD2/iy+E0887VL+ZJ49EZ7Vxfr9s
        QXfnxnZyi2HoxgVle7KxX68b4JIIGrQI/AbP
X-Google-Smtp-Source: APXvYqwckKbihNytza45QZsltEB/MDJqnRgjYzMjFCZ0dtdDbXhtUUZWPablqNPawdiu3JdQfr+hNA==
X-Received: by 2002:a19:bec5:: with SMTP id o188mr3518166lff.140.1573664640846;
        Wed, 13 Nov 2019 09:04:00 -0800 (PST)
Received: from ?IPv6:2a00:1370:812c:3592:78e6:4794:4f9c:243a? ([2a00:1370:812c:3592:78e6:4794:4f9c:243a])
        by smtp.gmail.com with ESMTPSA id g21sm1202642ljh.2.2019.11.13.09.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:04:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [Y2038] [PATCH 13/16] hfs/hfsplus: use 64-bit inode timestamps
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <CAK8P3a1Bvdb4Xn1Aqfnxnn24HPb6FXxAAVwq8ypO31AqoR1hBw@mail.gmail.com>
Date:   Wed, 13 Nov 2019 20:03:56 +0300
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        =?utf-8?B?IkVybmVzdG8gQS4gRmVybsOhbmRleiI=?= 
        <ernesto.mnd.fernandez@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09B5EC34-DE6B-4017-A842-7983E7874F98@dubeyko.com>
References: <20191108213257.3097633-1-arnd@arndb.de>
 <20191108213257.3097633-14-arnd@arndb.de>
 <2520E708-4636-4CA8-B953-0F46F8E7454A@dubeyko.com>
 <CAK8P3a1Bvdb4Xn1Aqfnxnn24HPb6FXxAAVwq8ypO31AqoR1hBw@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 13, 2019, at 11:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> On Wed, Nov 13, 2019 at 7:00 AM Viacheslav Dubeyko <slava@dubeyko.com> =
wrote:
>>> On Nov 9, 2019, at 12:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> * There are two time systems.  Both are based on seconds since
>>> * a particular time/date.
>>> - *   Unix:   unsigned lil-endian since 00:00 GMT, Jan. 1, 1970
>>> + *   Unix:   signed little-endian since 00:00 GMT, Jan. 1, 1970
>>> *    mac:    unsigned big-endian since 00:00 GMT, Jan. 1, 1904
>>> *
>>> + * HFS implementations are highly inconsistent, this one matches =
the
>>> + * traditional behavior of 64-bit Linux, giving the most useful
>>> + * time range between 1970 and 2106, by treating any on-disk =
timestamp
>>> + * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
>>> */
>>> -#define __hfs_u_to_mtime(sec)        cpu_to_be32(sec + 2082844800U =
- sys_tz.tz_minuteswest * 60)
>>> -#define __hfs_m_to_utime(sec)        (be32_to_cpu(sec) - =
2082844800U  + sys_tz.tz_minuteswest * 60)
>>=20
>> I believe it makes sense to introduce some constant instead of =
hardcoded value (2082844800U and 60).
>> It will be easier to understand the code without necessity to take a =
look into the comments.
>> What do you think?
>=20
> Every other user of sys_tz.tz_minuteswest uses a plain '60', I think =
that one
> is easy enough to understand from context. Naming the other constant
> is a good idea, I've now folded the change below into my patch.
>=20
> Thanks for the review!
>=20
>      Arnd
>=20
> 8<-----
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 26733051ee50..f71c384064c8 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -247,22 +247,24 @@ extern void hfs_mark_mdb_dirty(struct =
super_block *sb);
>  *
>  * HFS implementations are highly inconsistent, this one matches the
>  * traditional behavior of 64-bit Linux, giving the most useful
>  * time range between 1970 and 2106, by treating any on-disk timestamp
> - * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
> + * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
>  */
> +#define HFS_UTC_OFFSET 2082844800U
> +
> static inline time64_t __hfs_m_to_utime(__be32 mt)
> {
> -       time64_t ut =3D (u32)(be32_to_cpu(mt) - 2082844800U);
> +       time64_t ut =3D (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);
>=20
>        return ut + sys_tz.tz_minuteswest * 60;
> }
>=20
> static inline __be32 __hfs_u_to_mtime(time64_t ut)
> {
>        ut -=3D sys_tz.tz_minuteswest * 60;
>=20
> -       return cpu_to_be32(lower_32_bits(ut) + 2082844800U);
> +       return cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET);
> }
> #define HFS_I(inode)   (container_of(inode, struct hfs_inode_info, =
vfs_inode))
> #define HFS_SB(sb)     ((struct hfs_sb_info *)(sb)->s_fs_info)
>=20
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 22d0a22c41a3..3b03fff68543 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -538,20 +538,22 @@ int hfsplus_read_wrapper(struct super_block =
*sb);
>  *
>  * HFS+ implementations are highly inconsistent, this one matches the
>  * traditional behavior of 64-bit Linux, giving the most useful
>  * time range between 1970 and 2106, by treating any on-disk timestamp
> - * under 2082844800U (Jan 1 1970) as a time between 2040 and 2106.
> + * under HFSPLUS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and =
2106.
>  */
> +#define HFSPLUS_UTC_OFFSET 2082844800U
> +
> static inline time64_t __hfsp_mt2ut(__be32 mt)
> {
> -       time64_t ut =3D (u32)(be32_to_cpu(mt) - 2082844800U);
> +       time64_t ut =3D (u32)(be32_to_cpu(mt) - HFSPLUS_UTC_OFFSET);
>=20
>        return ut;
> }
>=20
> static inline __be32 __hfsp_ut2mt(time64_t ut)
> {
> -       return cpu_to_be32(lower_32_bits(ut) + 2082844800U);
> +       return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
> }
>=20
> /* compatibility */
> #define hfsp_mt2ut(t)          (struct timespec64){ .tv_sec =3D =
__hfsp_mt2ut(t) }

Looks good for me. I like the patch.

Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Vyacheslav Dubeyko.

