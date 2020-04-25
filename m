Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A281B8826
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 19:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDYRcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgDYRcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:32:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01490C09B050
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2020 10:32:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so6241716pgb.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2020 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=w41+bZlNoROIAm9e5f0pSCKyQF/SBw7z23NMeLYGmzk=;
        b=F6M4rQMIwupDNp8mlRN0m5JZlY7sYOsc/V5TEBpvrzmXH2zAajRBMadPdV6U/mLyU1
         IWpOgEx+ckUo51ovq2gw252+2NSBkD4B3Mba/5vLnCybEEo4xysQuw2TYmkZxqVNuVha
         M1ycfwvY5bXLI7tt2U8gsryb+So1AXn4/IJzlF3ZHZU0sNF//7M6GzfmQQ3ot3mw4zzj
         tPwF/Dn973hix6+ggAVE+qE+VMKxb3oIkbdsh7B2QGLUjqRJdIio7B7R3VT9laa+dufy
         Q105fL53erN2kiKFR7ngGRZv1KV3C0mXIkj6lwpNWT07IvYuxF22d1EGsGQkb/5Jfpfe
         auDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=w41+bZlNoROIAm9e5f0pSCKyQF/SBw7z23NMeLYGmzk=;
        b=t+PDXXE+O2p44C+zefCUr2XkzSzlMPDR/J+KKmHLtUa2yHRlcwrDlK/g1t0FiQiQIz
         s42lhJtTUGAh/Xf4gBR7Gv19+uZy4j3Ye+ZbRyITaITo9zeK2g/vVjZn1uxnJPQGHEzh
         xWTzOHPJ+hsFHCxJE+D/F6EYhX0S6Y4yJ6xrAb24+JH1R/w4vvpPFhI13omGMTGb/kG8
         Q9qP0IrYytF4PfyyYd8kkFNr9xU2MEj04IM7dGNv0keRQzz1E3UkYitb+8gNOhs4T2bO
         04UKLdaXlGgoKX3zQFunN09gaggR+32c473vhoPQF7kQsLqpBs7219t2rbUkh4BJeug1
         TzAA==
X-Gm-Message-State: AGi0Pua+03SvjUjGEoc5RRRgEtoLs/+dnR3cIfI0/QHtROiLYmiNv2XH
        fA+IKZ4J+ukGcb7/s2yUjfYOQN+wmV6EwQ==
X-Google-Smtp-Source: APiQypIqUtzrqajXu/yR5vzclJO9bBfOiZFCTI/VTUYxq8Ohlu2jF4IVKHoWNu4x2cCMkyu+cKiOvw==
X-Received: by 2002:aa7:943c:: with SMTP id y28mr15703323pfo.171.1587835966178;
        Sat, 25 Apr 2020 10:32:46 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id o1sm7415521pjs.39.2020.04.25.10.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 10:32:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Date:   Sat, 25 Apr 2020 10:32:44 -0700
Message-Id: <ECEA80AE-C2E9-4D5C-8A14-E2A92C720163@dilger.ca>
References: <20200425094350.GA11881@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
In-Reply-To: <20200425094350.GA11881@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Apr 25, 2020, at 02:43, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> =EF=BB=BFOn Sat, Apr 25, 2020 at 12:11:59PM +0300, Amir Goldstein wrote:
>> FWIW, I agree with you.
>> And seems like Jan does as well, since he ACKed all your patches.
>> Current patches would be easier to backport to stable kernels.
>=20
> Honestly, the proper fix is pretty much trivial.  I wrote it up this
> morning over coffee:
>=20
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fiemap-=
fix
>=20
> Still needs more testing, though.

The "maxbytes" value should be passed in from the caller, since this
may be different per inode (for ext4 at least).

Cheers, Andreas=
