Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A54151817
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgBDJqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 04:46:50 -0500
Received: from mout.web.de ([212.227.15.14]:58417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgBDJqu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580809592;
        bh=jF927DB3VXu5u5mQAoMf32fiOBhmu/Dc8LoZF5IpWMk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=HmSfxKcjH5Ix30bUhLY1GnIdE0ZeliZCnddWmaPnaWNioOm6xRSbrTEGEdY0s0/0j
         k3T7RzuTFfETLfh1vCSCsNOADeoGnj3Z8RSt9s00gEUIoUBupUjLrO5siwrmHbercD
         JbjDkAGMGSGiNibr6RfiIDSAydwI7VHLPlfSWq8Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFtKQ-1inJOQ0hIk-00EuiX; Tue, 04
 Feb 2020 10:46:32 +0100
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v10 1/2] fs: New zonefs file system
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <68ef8614-87f8-1b6e-7f55-f9d53a0f1e1c@web.de>
Date:   Tue, 4 Feb 2020 10:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:txhbm/UPmnTz4d/SeuQXHMWgaT8T58QatEzaJtJkUMHbnGSc4/V
 nqPOd+OZ7xwjI5DJTgXWYAjPWtKeQcJgPYpzSohJY0ZAJCNuMnvMeG8j1coi9GRXu/AhsUk
 vnTyYkz/g4ff55OSQGg/eY6BCkC6ggubqKzFndie26F8XEMMUncr7B+97uMn2F9IuYxVmA9
 WphnYiI2zBb8/x5T4V7VQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fw5ETYDBrTE=:wYtIFUdwcLSbAPNiGv7gsi
 yNyAHrwIxzrFhfjasgunc96GCnw5Ktu5H36rKjP+29C8W/U3aRjFAYR1XGQUNbENfxLFlEzIX
 a6oBn2ZyhZLz8m11iwl5DDkSDV6wmwxEjQW+GAQh0WQEtOhcBAIAYfS93Wu6HdDv6cwQBzi02
 PUD4HSdw8CqLpcv/pASePV+z/+8lZOCmmgP8BCifpuWB8E8VszAM2RspZoRgVhVuHl16uk1lc
 fbEp/Kt7zi2wZah1dqKyKIDbOjp+dp3rRQ2VcjNVeftIZfg0wNfMo7XmObfcZ7SXnYsrPcPT2
 6lnriNph1Y7lFUMs+GZecau0DRo6XLbGufjDayVzJvegDfLSqd9eLWo0f6o8I+tz5iHRzWVaL
 75kr4aebeEoeeq1xKb1zv/d1aHE+6U6supNyXXJnDk/c4KJ3LwvVuVDgFDEZew61yV7DaAR91
 rvqGCRxrKpJAj219xRXdd/kUmWrsajxPB1/Mv4F5Yvq+OFFm6H+SBLyE2JXvYuKb2GLupSXdJ
 W416zBvkn0IO87e/2evZj5cwRIympLtzZ+4Ab0Q/6lwmnpj6o121Vd6pY6HhZgqRkMiv0+vqN
 q+swQIWFGI0RgbY5LK3YQL2DnbY9SkDzDBGRkdEmWTf4SEsUNBBCVxCMhkyG6I4J/izjwFG1A
 DutFTaBRv01zfAhaqJFJuB5DLOQxO6iKpryp0w4qvdXoWDU1ukp5tA7ndh7E3UL6vC4+snhYf
 1pyb8RleVQXn1zSmQ0SSgp+oc9oXo0xdIV3qv4ehlWglT7tXz08elolE+nNUpcWumj6rOJeHS
 K2Ci+uJOuXiR7bMK0ze2ZOllj/ZScATF1TJD4PPSj5vHHTgj+DM3AwW292tS7Nt7NzM51hmag
 LdGMuw8Vb2y+365WmxH8UrxDxlpf4EbQavBMBBAO4jzJ30Def1lH03BTnCHRNK6ciGw0/F2GJ
 eAW+/wxmU2d+KSMcpIeyuho2M2+5yWI7jsY8fOrLh/+v+RTUhkdpgVMXDp1h5m/Pp9ixmXFAm
 XEcTJcOw2BHhMbQ9co/FsUTutgSzFepFBRkAfEMWHtaTGbqwA1cfVx3AvxRHGBLIcbpS4aYYp
 XORxK0c/44HSIXzEo0n/UhsqqDyZN/MFoy6aqHz1TBH+T+QgCTXWsd3qZb5XQ2gDIHREknZHw
 F5LYL1w76I1q04Pi3mkcVdl2lj7c5wz7lDPGR7t37wMJR0YpOXgseEwR2SCfTNKr56ZIJx1ye
 oBqlXqKCw57gKzQ0V
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/zonefs/super.c
=E2=80=A6
> +static const char *zgroups_name[ZONEFS_ZTYPE_MAX] =3D { "cnv", "seq" };

Can this array be treated as immutable?
How do you think about to use the following code variant?

+static const char const *zgroups_name[ZONEFS_ZTYPE_MAX] =3D { "cnv", "seq=
" };

Regards,
Markus
