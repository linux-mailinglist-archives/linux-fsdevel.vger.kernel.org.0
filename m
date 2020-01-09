Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79699136300
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgAIWER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 17:04:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44849 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:04:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id t3so157454qtr.11;
        Thu, 09 Jan 2020 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=mYYRhkuZDGTmH8A/CCqbCYP6JuoA0cdwzxVenF2dSZ0=;
        b=mzvJVX2Fzp1VjDakSF1A3fw4acUf2/LmE9/zEVaKYRjFMR5cyyMv1i5cn/Xp+s17in
         98O8giPhUma6YpWQCU5SPHho/8G1XTqYihjcsajX4QJ2ZIXtN7OaS47J5e4nOYOdb1gQ
         pVJtfFnioZmXAlAg3/g7REynbCcXdkNOxZnAtpp/Nt3Q7YpFVbqNIsu+MhGPUfcCS6Ll
         OH7zYFGJJSCWYR2l1kDpKwO+dYwu3U+HM9Hoq/l4p3Kbtuj9jOEzOIPsQByL3tLlnUSP
         mB8mBDHdS5NZTrDQ8fKGMC1cnQd237JraSFfaMhdlXJ7pjaM6DAqp070a8bh0/DcwqNe
         ZmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=mYYRhkuZDGTmH8A/CCqbCYP6JuoA0cdwzxVenF2dSZ0=;
        b=JCC3mfEGXz02RZ0YQ7YnW1MSugYw5UpL966qawSdFmjBtmo5o3BML3J551P7TWiZ+K
         TFUTi6lFuQvUI8DuT10kobvmD/jy7el2wYstXNugMnN2DPRxb/1HViU8I4L47ZXLEEU5
         5SEVIqxgJl1V5RM1u8I04Ix5AUSP+IfQRtftraFEKqUdYEh3SGVo8Ht6pJg4nMGeLsHq
         +RwkgW/Y8ec6zYIrM1vd0neszejIozLsDPyHcygRGhJyrgHgy8aJN8UfIt/Ndh/6Sps4
         14TS5GuhsO+Du9HgRl7dfiT92AZiLdKXbsan4cvF4Kj9Vgmnu0E1yXBRw4oC0xfArcDe
         2LGA==
X-Gm-Message-State: APjAAAXfTR+0zmBO6oZrKRK87hyZn00nj8tzkMks7KhSwyzyGCdZbS4M
        Rs1zhtU+TQBdIkeSmt5LwpY=
X-Google-Smtp-Source: APXvYqziswXcvy80PCLg3bRmvFEdbmL7ZjtsrARb5PD7IgYC3Br7236xOmWBD7EZ8pYdqM3OvY4sgg==
X-Received: by 2002:ac8:1e05:: with SMTP id n5mr9883387qtl.227.1578607456681;
        Thu, 09 Jan 2020 14:04:16 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id r12sm3678459qkm.94.2020.01.09.14.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 14:04:16 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@gmail.com>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@gmail.com>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <namjae.jeon@samsung.com>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        linkinjeon@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
In-reply-to: <20200107115202.shjpp6g3gsrhhkuy@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com> <20200102082036.29643-11-namjae.jeon@samsung.com> <20200105165115.37dyrcwtgf6zgc6r@pali> <85woa4jrl2.fsf@collabora.com>
 <20200107115202.shjpp6g3gsrhhkuy@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 09 Jan 2020 17:04:15 -0500
Message-ID: <47625.1578607455@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When compiling on a 32-bit system like Raspian on an RPi4, the compile di=
es:

  CC =5BM=5D  fs/exfat/misc.o
fs/exfat/misc.c: In function 'exfat_time_unix2fat':
fs/exfat/misc.c:157:16: error: 'UNIX_SECS_2108' undeclared (first use in =
this function); did you mean 'UNIX_SECS_1980'?
  if (second >=3D UNIX_SECS_2108) =7B
                =5E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E
                UNIX_SECS_1980
fs/exfat/misc.c:157:16: note: each undeclared identifier is reported only=
 once for each function it appears in
make=5B2=5D: *** =5Bscripts/Makefile.build:266: fs/exfat/misc.o=5D Error =
1

The problem is that the definition of UNIX_SECS_2108  is wrapped:

+=23if BITS_PER_LONG =3D=3D 64
+=23define UNIX_SECS_2108    4354819200L
+=23endif

but the usage isn't.
