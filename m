Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D6140228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 04:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgAQC7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 21:59:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:17849 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389095AbgAQC7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:59:35 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200117025931epoutp03bf9e8ab4d5e624a9cc30c08bdd938de2~qjUrCxRYS0980709807epoutp03D
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 02:59:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200117025931epoutp03bf9e8ab4d5e624a9cc30c08bdd938de2~qjUrCxRYS0980709807epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579229971;
        bh=KjrIkDdlRMvRt8qo00N+7BUNTvZULChW1Gqc6V6oOLM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RTkmzx/cVh4iOvCABsgsSkvseIF0rOcHVbWZvHz2G1KlHY7RWceAL8oZKk220SWf3
         ZW4XyUwsJB2p79UYdqF0Ruonp55b5bC2sl5vYFVwqTJ2KioVXB5GNt/mSqPoBbo3Nn
         4EwyuVwaxg2A0d1nyN5w/yogzDbr281lwZo5nRUo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117025930epcas1p2b70ca37d444b8ef5e0df2acbd6ef5004~qjUqU8XeA0521805218epcas1p21;
        Fri, 17 Jan 2020 02:59:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47zQl56B8YzMqYkb; Fri, 17 Jan
        2020 02:59:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.6A.48019.113212E5; Fri, 17 Jan 2020 11:59:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200117025929epcas1p3daf55818eec5a1acecb1d793ad7b0173~qjUo6RSu51290112901epcas1p3_;
        Fri, 17 Jan 2020 02:59:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117025929epsmtrp1e42ceb2a912f02e102dacde746c5f5c9~qjUo2tCxU0516405164epsmtrp1M;
        Fri, 17 Jan 2020 02:59:29 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-9b-5e212311d954
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.0F.06569.113212E5; Fri, 17 Jan 2020 11:59:29 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200117025929epsmtip2a5457aa015a9cd02d66054cc8bf8c9bd~qjUou_59z1176811768epsmtip2p;
        Fri, 17 Jan 2020 02:59:29 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     "'Namjae Jeon'" <linkinjeon@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "'Linux FS-devel Mailing List'" <linux-fsdevel@vger.kernel.org>,
        "'gregkh'" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "'Christoph Hellwig'" <hch@lst.de>, <sj1557.seo@samsung.com>
In-Reply-To: <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
Subject: RE: [PATCH v10 09/14] exfat: add misc operations
Date:   Fri, 17 Jan 2020 11:59:29 +0900
Message-ID: <002801d5cce2$228d79f0$67a86dd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDl4arpJeuFoAiOGgh7zDYNQFC3mAHvmPGdAYS70pMCTZrZ/wIalS1qAZ8YAg8BhDMOogFX8NFhAlVLKr8BX6mCFwHtIwURqT4Yc0A=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0hTYRjHe3e2czZxdZxWL5a2jihZqJtz81guhCzWBVoFIUKuo568tBs7
        m6QWCYK3xNIv2lQshEIzFNM004xZill90NAmWZJmaZGpmJYXOvMo+e33Pu//ef7P816EiKQV
        9RamGK20xUjpCdSN/7grMDjIw29vnOzdhJxcKenGyOzqepSsefCSRw6NDCNke0cvnxxoq0DJ
        4r4lHtm0+kJA9k//4keJNEt/S4DmiX0E03RW1mGap84sVFPUVAs0c42+GkfLD1SLxeojk2kq
        kbZIaWOCKTHFmKQmTp7THdEpVTJ5kDyCDCekRspAq4noU9qgYyl6tjVCmkbpbWxISzEMEXI4
        0mKyWWlpsomxqgnanKg3y2XmYIYyMDZjUnCCyXBQLpOFKlnlRX1yQ/OEwDy77cqjal0W+OxW
        AERCiIfB58N1/ALgJpTgrQA67/Qj3GIWwLkbn3kulQT/DWB+1YWNjNHyTwJO1AHgw5EejFtM
        AljzulPgUqF4EFxd7kRd7IX7w6nxp2siBB/lwaFnM4hrQ4Sfgf1d05iLPfEIlrvXmM8mjLYX
        AheL2Xhd9ns+xx6w9/b4GiP4AXjv7neEa0kK/3y5J+DiXrA8PwfhjNPg1GIJcBlDPBeDg8Nd
        gEuIhmNjr3gce8KpniaMY284eTOHZSHLmXCmc71+HoDfFtQcK6CzvkHgkiB4IKxvC+HCe+GT
        pUrAtbAV/pwvFHBVxDAvR8JJ/GFRf9e66S5YkPsLuwUI+6bB7JsGs28axv7f7A7g14IdtJkx
        JNGM3By2+a4bwdqr3U+2gva3pxwAFwLCXVx2VhonEVBpTLrBAaAQIbzEvWU+cRJxIpWeQVtM
        OotNTzMOoGTPvRjx3p5gYv+A0aqTK0MVCgUZpgpXKRXETnFpNFsHT6Ks9GWaNtOWjTyeUOSd
        BbRHD7WovrvnOjIqAqb7So7vi7qU/uF0w4OVqq+GOR9pwNiW8JAT55U5WVcX1BPO+MXjvuXX
        SgeJ1fyP13Mz7yNvRDEzRbWtqvE/vveZthoTqdBXxTybz58qt8cE/m2XaIEqddl2Or66Zyh2
        d+CejE9YxbaG1KiAgR6nXzPqqBQTfCaZku9HLAz1DwlGIofLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK6gsmKcwbG/3BZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLCae/s1kseXfEVaLS+8/sDhwevz+NYnRY+esu+we++eu
        YffYfbOBzaNvyypGj8+b5DwObX/DFsAexWWTkpqTWZZapG+XwJWxv+08a8Fb/ooXhyeyNTBe
        5upi5OSQEDCReDD7PmsXIxeHkMBuRoknV5awQSSkJY6dOMPcxcgBZAtLHD5cDFHznFHi7O4V
        zCA1bAK6Ev/+7AerFxFQlXj1ZDc7SBGzwDMmietvO9ghOvpYJa4fms8IUsUpEChx6fB7dhBb
        WMASyD4GZrMAdT/Y0wNWwwsUX9N8gwXCFpQ4OfMJmM0soC3R+7CVEcZetvA1M8SlChI/ny5j
        hYiLSMzubGOGuKhM4tWPSYwTGIVnIRk1C8moWUhGzULSvoCRZRWjZGpBcW56brFhgVFearle
        cWJucWleul5yfu4mRnDkaWntYDxxIv4QowAHoxIP74wghTgh1sSy4srcQ4wSHMxKIrwnZ8jG
        CfGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamAM49Pf3P7X
        4/eU+5se7+FfvEk7QyVfvKh9Of8ejndrj2z8mLbq+tFjRmLtXxf0rvRMNL4XlvNHUPF1kwhv
        mvjJLuP8W0nzY1N22Sq5qr72PXTP68WNr30HTDxXr69wje1YlahUarPrVrXKFv4GrX1fX79W
        jfwit2bWl29M839o8y3lXJJ7dIeEEktxRqKhFnNRcSIAxHOEf7gCAAA=
X-CMS-MailID: 20200117025929epcas1p3daf55818eec5a1acecb1d793ad7b0173
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
        <20200115082447.19520-1-namjae.jeon@samsung.com>
        <20200115082447.19520-10-namjae.jeon@samsung.com>
        <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
        <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
        <20200115133838.q33p5riihsinp6c4@pali>
        <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
        <20200115142428.ugsp3binf2vuiarq@pali>
        <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
        <20200115153943.qw35ya37ws6ftlnt@pali>
        <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=20
> This is what I think the timezone mount option should be used
> for: if we don't know what the timezone was for the on-disk timestamp, us=
e
> the one provided by the user. However, if none was specified, it should b=
e
> either sys_tz or UTC (i.e. no conversion). I would prefer the use of UTC
> here given the problems with sys_tz, but sys_tz would be more consistent
> with how fs/fat works.
Hi Arnd,

Could you please review this change ?

/* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
                __le16 time, __le16 date, u8 tz)
=7B      =20
        u16 t =3D le16_to_cpu(time);
        u16 d =3D le16_to_cpu(date);
       =20
        ts->tv_sec =3D mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d & 0x001=
F,
                              t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1=
);
        ts->tv_nsec =3D 0;
       =20
        if (tz & EXFAT_TZ_VALID)
                /* Adjust timezone to UTC0. */
                exfat_adjust_tz(ts, tz & =7EEXFAT_TZ_VALID);
        else   =20
                /* Convert from local time to UTC using time_offset. */
                ts->tv_sec -=3D sbi->options.time_offset * SECS_PER_MIN;
=7D

/* Convert linear UNIX date to a EXFAT time/date pair. */
void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
                __le16 *time, __le16 *date, u8 *tz)
=7B
        struct tm tm;
        u16 t, d;

        time64_to_tm(ts->tv_sec, 0, &tm);
        t =3D (tm.tm_hour << 11) =7C (tm.tm_min << 5) =7C (tm.tm_sec >> 1);
        d =3D ((tm.tm_year - 80) <<  9) =7C ((tm.tm_mon + 1) << 5) =7C tm.t=
m_mday;

        *time =3D cpu_to_le16(t);
        *date =3D cpu_to_le16(d);

        /*
         * Record 00h value for OffsetFromUtc field and 1 value for OffsetV=
alid
         * to indicate that local time and UTC are the same.
         */
        *tz =3D EXFAT_TZ_VALID;
=7D

Thanks=21

