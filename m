Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDABC1363DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgAIXfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 18:35:40 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:43743 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:35:40 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200109233536epoutp02c5e50ee43f4f4530fbd7f76ecade9716~oXBn4Vhlf0484504845epoutp02K
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2020 23:35:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200109233536epoutp02c5e50ee43f4f4530fbd7f76ecade9716~oXBn4Vhlf0484504845epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578612936;
        bh=BcILnUuT8NSz+uWKYtx6IIz/i3shvGWRg7ONXzgqZMw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AaJuz3XJEynAJwTbesnKSWrS+1bGVLiEQTsvCMt15r32nvVb+YEAzCIuX6/6DUxi4
         tAq3RpTpLx7V5fxCyNS3aDD+LDlwORTRsqMdvRjp/l+XQYBB/IQT4aeZKVT88qovkv
         D+ow9wNn5YAjP9fUuTDr8gUrkhP3rn7K59Ylh+ws=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200109233535epcas1p3f995496fafc5bc602f311ee8fc93009f~oXBnfqrP81708817088epcas1p39;
        Thu,  9 Jan 2020 23:35:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47v2Y254X7zMqYkV; Thu,  9 Jan
        2020 23:35:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.6F.57028.6C8B71E5; Fri, 10 Jan 2020 08:35:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109233534epcas1p21c284752f0c766afac8e0a5e04c3a1c7~oXBmUB7xd1732717327epcas1p2Z;
        Thu,  9 Jan 2020 23:35:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109233534epsmtrp119a9af1733c6193b3b7c9b0f394aceaf~oXBmTR-1a2048320483epsmtrp1c;
        Thu,  9 Jan 2020 23:35:34 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-25-5e17b8c650e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.97.06569.6C8B71E5; Fri, 10 Jan 2020 08:35:34 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200109233534epsmtip239485ee8ef98de3fb1b9dc9c7d49ffec~oXBmI6ZiR1016910169epsmtip2L;
        Thu,  9 Jan 2020 23:35:34 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Linux FS-devel Mailing List'" <linux-fsdevel@vger.kernel.org>,
        "'gregkh'" <gregkh@linuxfoundation.org>,
        "'Valdis Kletnieks'" <valdis.kletnieks@vt.edu>,
        "'Christoph Hellwig'" <hch@lst.de>, <linkinjeon@gmail.com>,
        <Markus.Elfring@web.de>, <sj1557.seo@samsung.com>
In-Reply-To: <CAK8P3a2_-xkiV0EeemKDNgsU+Xv+fROmsTUa6j0hBaQSCPKMag@mail.gmail.com>
Subject: RE: [PATCH v2 09/13] exfat: add misc operations
Date:   Fri, 10 Jan 2020 08:35:34 +0900
Message-ID: <001f01d5c745$7d0a3730$771ea590$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIO0WjshxKMSWeYsuMMUIV1/yRWXwEo1XJlAasenHwCCphkCadJ8vHw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmvu6xHeJxBi1vNCz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzVYsu/I6wWl95/YHHg9Pj9axKjx85Zd9k99s9d
        w+6x+2YDm0ffllWMHp83yXkc2v6GzeP2s20sARxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
        pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QPcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMo7eO8pUsI23YkrXYsYGxl6uLkZODgkB
        E4lnu34wdjFycQgJ7GCUmP6rmRXC+cQosf3fEnaQKiGBb4wS3SvEuhg5wDr+f7KAqNnLKPH2
        +EEWCOclo8TmM69YQRrYBHQl/v3ZzwZiiwioSrx6shtsELPAZiaJI68kQWxOgUCJWVN3MoEM
        FRawkJjZUgUSZgEq/zv3BjOIzStgKfH+9kMWCFtQ4uTMJywQY+Qltr+dwwzxgYLEz6fLWCFW
        uUl827qCGaJGRGJ2ZxszyG0SApPZJV5tOMQC0eAisWb1QVYIW1ji1fEt7BC2lMTL/jZ2iCer
        JT7uh5rfwSjx4rsthG0scXP9BlaQEmYBTYn1u/QhwooSO3/PZYRYyyfx7msPK8QUXomONiGI
        ElWJvkuHmSBsaYmu9g/sExiVZiF5bBaSx2YheWAWwrIFjCyrGMVSC4pz01OLDQsMkWN6EyM4
        4WqZ7mCccs7nEKMAB6MSD2+GsHicEGtiWXFl7iFGCQ5mJRHeozfE4oR4UxIrq1KL8uOLSnNS
        iw8xmgLDfSKzlGhyPjAb5JXEG5oaGRsbW5iYmZuZGiuJ83L8uBgrJJCeWJKanZpakFoE08fE
        wSnVwJh15euC306fsqs3TlacIdG/vWKRsEWzx/I7T1aFCWdxva6dGy0reOLW54dbT66e8UPn
        j4JZ0+flp9nPFB2aWxNSWr2pKFKEc6F778WVjFIXFzS7ttZ9WKNZs29yTgHD2sCr6iKxyYd8
        dpTNneaXf/tvm5pyw/T1U2cw1J5W+7G5LjvITHKJ1xIlluKMREMt5qLiRACyfbClzgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvO6xHeJxBnP/8Fr8nXSM3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxZZ/R1gtLr3/wOLA6fH71yRGj52z7rJ77J+7
        ht1j980GNo++LasYPT5vkvM4tP0Nm8ftZ9tYAjiiuGxSUnMyy1KL9O0SuDKO3jvKVLCNt2JK
        12LGBsZeri5GDg4JAROJ/58suhi5OIQEdjNKzPu8n62LkRMoLi1x7MQZZogaYYnDh4shap4z
        Sry+eZcRpIZNQFfi3x+IehEBVYlXT3azgxQxC+xkkujr6GOB6Ghmkph26SxYB6dAoMSsqTuZ
        QKYKC1hIzGypAgmzADX/nXuDGcTmFbCUeH/7IQuELShxcuYTMJtZQFvi6c2nULa8xPa3c5gh
        DlWQ+Pl0GSvEEW4S37auYIaoEZGY3dnGPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucW
        GxYY5aWW6xUn5haX5qXrJefnbmIEx5+W1g7GEyfiDzEKcDAq8fBmCIvHCbEmlhVX5h5ilOBg
        VhLhPXpDLE6INyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QD
        o7rk7F8tRzgW9gaorI9X6M1/5rF2xY5Vop/jWua8NDwc6JD2yj3a9KJu5yJvhm9lHZ2hPo6f
        v77LnaKZ8N8xd5VLStWlBRY2K7ftLTV6t3nizStue/71XK5rCG+NUnzxqCsi4ndI7u9d3ksu
        Gk8P2a+2i8lmn8esSR9erzi+e+vHEOuV0bJTvymxFGckGmoxFxUnAgBbCIY4uwIAAA==
X-CMS-MailID: 20200109233534epcas1p21c284752f0c766afac8e0a5e04c3a1c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b
References: <CGME20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b@epcas1p2.samsung.com>
        <20191119071107.1947-1-namjae.jeon@samsung.com>
        <20191119071107.1947-10-namjae.jeon@samsung.com>
        <CAK8P3a2_-xkiV0EeemKDNgsU+Xv+fROmsTUa6j0hBaQSCPKMag@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Tue, Nov 19, 2019 at 8:16 AM Namjae Jeon <namjae.jeon@samsung.com>
> wrote:
> 
> > +/* <linux/time.h> externs sys_tz
> > + * extern struct timezone sys_tz;
> > + */
> > +#define UNIX_SECS_1980    315532800L
> > +
> > +#if BITS_PER_LONG == 64
> > +#define UNIX_SECS_2108    4354819200L
> > +#endif
> > +
> > +/* days between 1970/01/01 and 1980/01/01 (2 leap days) */
> > +#define DAYS_DELTA_DECADE    (365 * 10 + 2)
> > +/* 120 (2100 - 1980) isn't leap year */
> > +#define NO_LEAP_YEAR_2100    (120)
> > +#define IS_LEAP_YEAR(y)    (!((y) & 0x3) && (y) != NO_LEAP_YEAR_2100)
> > +
> > +#define SECS_PER_MIN    (60)
> > +#define SECS_PER_HOUR   (60 * SECS_PER_MIN)
> > +#define SECS_PER_DAY    (24 * SECS_PER_HOUR)
> 
> None of this code should exist, just use time64_to_tm() and tm_to_time64()
Okay, Will use them.
> 
> > +       if (!sbi->options.tz_utc)
> > +               ts->tv_sec += sys_tz.tz_minuteswest * SECS_PER_MIN;
> 
> I would make tz_utc the default here. Not sure what windows uses or what
> the specification says, but sys_tz is a rather unreliable interface, and
> it's better to not use that at all if it can be avoided.
> 
> It may be useful to have a mount option for the time zone offset instead.
Okay, Will add a time_zone_offset mount option.
> 
> > +       ts->tv_nsec = 0;
> > +}
> > +
> > +/* Convert linear UNIX date to a FAT time/date pair. */ void
> > +exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
> > +               struct exfat_date_time *tp)
> 
> This is basically time64_to_tm(), just be careful about to check whether
> months are counted from 1 or 0.
Okay.

Thanks for your review!
> 
>        Arnd

