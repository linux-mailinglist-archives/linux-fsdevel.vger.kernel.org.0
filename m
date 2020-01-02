Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA412E657
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgABNHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 08:07:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37807 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgABNHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:07:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so57017227otn.4;
        Thu, 02 Jan 2020 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qGzIj2hEHN6oUhF09deNE0mRdC/2mJvGlzqpU/pgTzc=;
        b=MA9MDfK4j+giCLMBFtV5LXU3X/dFRKK96EzQvldNXaq2a0/7Cv65d1OtEletP8Yr9/
         Gji9z0ORxK/xkqwrO5xcpE9I14uemIwqRhR8bMidxreukupIXK/kPuzgDojz1DN8xzu0
         +783oj2RHFziDPtLC5je0de+mVEy7U9ld6L6L5AS1tTvHse1lskx5AqiCrZnWNqVCuDR
         gAYqmWuvOF40FSU6Ljyp/WP0cg5p8jV9J5bpsduYDL+5dSRKO2vtgcXP4ul4TVbhyPbm
         vFHlvtAv0Ff7NvQA9afnO70n+U4SmY8kn0sZtvDlkB8Fz7adgA7UlA5B3RrnaLSbX/jG
         4v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qGzIj2hEHN6oUhF09deNE0mRdC/2mJvGlzqpU/pgTzc=;
        b=Ep99agNPwhfcIID8UCwbJkYo5alVFuujranwQy+PH+KebUCprqu++DL11Y9fXFdI67
         gP1SupJdypm/r+Y1WAXrlsZifx26XOKSZ4jode06PYtab8dzovsk6qvrFnz/1kawtZHC
         815AhTqhfcCuRdH9vn+7Ay143EnIX+pL9YWorZVePeUDUBHydsfxwoN5bU1CTNL0y/PV
         64OThuFzzkg/Q7Kb8r/YWzQbG3R6cEf2897TD5waT0cXREeLrzwU2kmylgm5/8gv6sHA
         tPxYjd9+jJml/Ga1E9JIukI0PqHfaZl8LBlFelw9b6LOMuSjIWYeuYA9ru4+YxFTPP0k
         6+uw==
X-Gm-Message-State: APjAAAXLrEwXvrGieDrqevS/Fl6+Q28RwKjuHlpi5/pV02JZhTU4vRlS
        h6RSVBcD2F+S9vqI7JvCkymiVdj5yZ/0y5V1vgY=
X-Google-Smtp-Source: APXvYqylOUvEdSWBW2l4DxzkLNI6zzyEGisPZ0pUpKpF7VMWrTzGQ0N22m/qX0E9fbp9LRz14CE0U1vJAi6XyRqumlo=
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr18134133otq.120.1577970437302;
 Thu, 02 Jan 2020 05:07:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Thu, 2 Jan 2020 05:07:16 -0800 (PST)
In-Reply-To: <20200102125830.z2uz673dlsdttjvo@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082408epcas1p194621a6aa6729011703f0c5a076a7396@epcas1p1.samsung.com>
 <20200102082036.29643-13-namjae.jeon@samsung.com> <20200102125830.z2uz673dlsdttjvo@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Thu, 2 Jan 2020 22:07:16 +0900
Message-ID: <CAKYAXd9Y6o+a7q_yismLP8nNXOUqrudC3KW8N6Z05OghYLt1jg@mail.gmail.com>
Subject: Re: [PATCH v9 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> index 98be354fdb61..2c7ea7e0a95b 100644
>> --- a/fs/Makefile
>> +++ b/fs/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+=3D hugetlbfs/
>>  obj-$(CONFIG_CODA_FS)		+=3D coda/
>>  obj-$(CONFIG_MINIX_FS)		+=3D minix/
>>  obj-$(CONFIG_FAT_FS)		+=3D fat/
>> +obj-$(CONFIG_EXFAT)		+=3D exfat/
>>  obj-$(CONFIG_BFS_FS)		+=3D bfs/
>>  obj-$(CONFIG_ISO9660_FS)	+=3D isofs/
>>  obj-$(CONFIG_HFSPLUS_FS)	+=3D hfsplus/ # Before hfs to find wrapped HFS=
+
>
> Seems that all filesystems have _FS suffix in their config names. So
> should not have exfat config also same convention? CONFIG_EXFAT_FS?
Yeah, I know, However, That name conflicts with staging/exfat.
So I subtracted _FS suffix.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
