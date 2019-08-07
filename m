Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91B852A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfHGSEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 14:04:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40239 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbfHGSEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:04:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so41886359pla.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2019 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=c+psdm6pvDnX8dyBc4Cy/c4pQsOMzehzZXsXXjLyHjE=;
        b=Hkqgbv8hZ+XxxwYQybA7A5S+54OG5Qr5zwrDp+yqEE3Yexv9ppnMZ8tB3Xtd0FvD2l
         +0kfPrsTSZAcA605PElWGVDrO8JBQKPyMLsuD98CBsWEfcl3q/NKidhSdmkCcn+BseHx
         wr6ZvSwAYnegb/4XK6eeMJ8ehFaZkBQ5PtDATgUdAk8oA+EYACiFIxjpvMai/FXhwy7e
         LuIoCcVTNGkJj6RSF0cWrwjdYMb9YrT8NZEbGQC08gSChEQ3o4HzY9m9ljVOUAbSH0CM
         Zo10RZVeJYzEqVYnT/sO9v7oTkeCcH8/2WIZttNR218xpAf/HF9EmxG/pSx6zSBdvBBE
         jXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=c+psdm6pvDnX8dyBc4Cy/c4pQsOMzehzZXsXXjLyHjE=;
        b=cug+U7Qd2sznMTSAie/6CT50svb5iIUhEFdvi6M3HE+hOPiSqBGWoyGnqGkP7zrczx
         QJa+91rVapNchB/2HDdkpxyirn19n7fDKqsKpWJanrv+SKz5EHu1tHHXAJL6PSAiK3Lt
         udKjwtazqI8R0edCHwfynX7P9vFswlVxkJpKSpwekMaQWtR+2l6GPA/JsZ8b6lF/yL/i
         L84q9D8Q449MyeDX+emEF1/qO//tq6lXPPyp0yM18G3Aj5MwFTsJBUVI2111hYGpRojg
         UyTzmW6Ngei0v18qz++8j5t+qizqHZ7C/qcwQ9KiFQ12+plR/SFjg3eCQogvOigGLFjr
         MVdA==
X-Gm-Message-State: APjAAAUwrZNh5e+j0MEjRMLvHur5BgoBhXPHBydMnq8gs73isL390lVW
        CGXAj3h0G7/QxIW5JGSm4dYxzg==
X-Google-Smtp-Source: APXvYqyKNvJRuoqJHT7zp4s4yyKagF58xy20LUmJGMO5Xp74ekq0e0mWnaeliyJ9QargqnhdGrxVpA==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr9442334plr.68.1565201088236;
        Wed, 07 Aug 2019 11:04:48 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id o14sm533198pjp.19.2019.08.07.11.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:04:47 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B4818187-623B-4A0C-8958-81E820E8F1E1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4A322069-BD5B-4078-8B8E-F73516BB60D1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
Date:   Wed, 7 Aug 2019 12:04:44 -0600
In-Reply-To: <CAK8P3a0aTsz4f6FgXf7NSAG+aVpd1rhZvFU_E4v8AY_stvhJtQ@mail.gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia>
 <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
 <20190801224344.GC17372@mit.edu>
 <CAK8P3a3nqmWBXBiFL1kGmJ7yQ_=5S4Kok0YVB3VMFVBuYjFGOQ@mail.gmail.com>
 <20190802154341.GB4308@mit.edu>
 <CAK8P3a1Z+nuvBA92K2ORpdjQ+i7KrjOXCFud7fFg4n73Fqx_8Q@mail.gmail.com>
 <20190802213944.GE4308@mit.edu>
 <CAK8P3a2z+ZpyONnC+KE1eDbtQ7m2m3xifDhfWe6JTCPPRB0S=g@mail.gmail.com>
 <20190803160257.GG4308@mit.edu>
 <CAK8P3a0aTsz4f6FgXf7NSAG+aVpd1rhZvFU_E4v8AY_stvhJtQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_4A322069-BD5B-4078-8B8E-F73516BB60D1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 3, 2019, at 2:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Sat, Aug 3, 2019 at 6:03 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> 
>> On Sat, Aug 03, 2019 at 11:30:22AM +0200, Arnd Bergmann wrote:
>>> 
>>> I see in the ext4 code that we always try to expand i_extra_size
>>> to s_want_extra_isize in ext4_mark_inode_dirty(), and that
>>> s_want_extra_isize is always at least  s_min_extra_isize, so
>>> we constantly try to expand the inode to fit.
>> 
>> Yes, we *try*.  But we may not succeed.  There may actually be a
>> problem here if the cause is due to there simply is no space in the
>> external xattr block, so we might try and try every time we try to
>> modify that inode, and it would be a performance mess.  If it's due to
>> there being no room in the current transaction, then it's highly
>> likely it will succeed the next time.
>> 
>>> Did older versions of ext4 or ext3 ignore s_min_extra_isize
>>> when creating inodes despite
>>> EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE,
>>> or is there another possibility I'm missing?
>> 
>> s_min_extra_isize could get changed in order to make room for some new
>> file system feature --- such as extended timestamps.
> 
> Ok, that explains it. I assumed s_min_extra_isize was meant to
> not be modifiable, and did not find a way to change it using the
> kernel or tune2fs, but now I can see that debugfs can set it.
> 
>> If you want to pretend that file systems never get upgraded, then life
>> is much simpler.  The general approach is that for less-sophisticated
>> customers (e.g., most people running enterprise distros) file system
>> upgrades are not a thing.  But for sophisticated users, we do try to
>> make thing work for people who are aware of the risks / caveats /
>> rough edges.  Google won't have been able to upgrade thousands and
>> thousands of servers in data centers all over the world if we limited
>> ourselves to Red Hat's support restrictions.  Backup / reformat /
>> restore really isn't a practical rollout strategy for many exabytes of
>> file systems.
>> 
>> It sounds like your safety checks / warnings are mostly targeted at
>> low-information customers, no?
> 
> Yes, that seems like a reasonable compromise: just warn based
> on s_min_extra_isize, and assume that anyone who used debugfs
> to set s_min_extra_isize to a higher value from an ext3 file system
> during the migration to ext4 was aware of the risks already.
> 
> That leaves the question of what we should set the s_time_gran
> and s_time_max to on a superblock with s_min_extra_isize<16
> and s_want_extra_isize>=16.
> 
> If we base it on s_min_extra_isize, we never try to set a timestamp
> later than 2038 and so will never fail, but anyone with a grandfathered
> s_min_extra_isize from ext3 won't be able to set extended
> timestamps on any files any more. Based on s_want_extra_isize
> we would keep the current behavior, but could add a custom
> warning in the ext4 code about the small s_min_extra_isize
> indicating a theoretical problem.

I think it makes the most sense to always try to set timestamps on
inodes that have enough space for them.  The chance of running into
a filesystem with 256-byte inode size but *no* space in the inode to
store an extended timestamp, but is *also* being modified by a new
kernel after 2038 is vanishingly small.  This would require formatting
the filesystem with non-default mke2fs for ext3, using the filesystem
and storing enough xattrs on inodes that there isn't space for 12 bytes
of extra isize, and using it for 30+ years without upgrading to use
ext4 (which will also try to expand the inode to store the nsec
timestamps) and then modifying the inode after 2038.

Rather than printing a warning at mount time (which may be confusing
to users for a problem they may never see), it makes sense to only
print such a warning in the vanishingly small case that someone actually
tries to modify the inode timestamp but it doesn't fit, rather than on
the theoretical case that may never happen.


Cheers, Andreas






--Apple-Mail=_4A322069-BD5B-4078-8B8E-F73516BB60D1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1LEr0ACgkQcqXauRfM
H+A+LQ/9Fq5j/fGRldiNeKqpnZ2jrnx4+eqCYfFqCoI02jN17/q+bWvHGtVbyBPP
lVHE7xlJbiogbUUmNsfLLp5CngSCqjsYp7dV21YcPpsdd7k26PJMDMw8lkY41LGI
AaDC948zRNF0Io+4ma8KXgLZWbFNEpPlCsKuMHbwAo7sQ/yuCauvJDengPA2IjLN
H289WlD9j0H6hrMcJmazdGhdF21+hGSLvK3vZvCjGiDTWNTGydz8guXel/tFkYJs
Flp7dD6dp7b2JnaiJTr5Hj9No2LfFgxBtNqGFuS8bA6waNlzfx8KzgeodeXWOPgo
6Sg2uEc8pxaXlAXsldVykYvo640a/uQUiWPiabIIqSdSyj2g4K6wx0GbYr3j3GCP
YheU5Khw1CtvAqDN+2CbQaon2WrLldJCqFo6KzQPmmlQnyLFQa6gT2kYrSXEzhIP
eFYGQxV1TLoyyQ6b3ab9J8kZZHPteVWuK+EyqkIxONXnazRkz77QK3wzQUy+V6+T
B403LR3x4JKOMYVKd41VAJMZHp8Uvf224oVxrxzovdJoRr3awWokvsBEr2+e+ihA
/c3+2oSO/0acNGCLbzX3KC/PpWx9keHHx6CxJIgnF+7avtsrkAR54H48stVZ05en
xr5H9dIZnce2CTM9Ylz3R7DerBaAuvEpl1sKpt8BE0OHyAzeffg=
=Lnwv
-----END PGP SIGNATURE-----

--Apple-Mail=_4A322069-BD5B-4078-8B8E-F73516BB60D1--
