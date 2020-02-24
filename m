Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588E616A370
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXKCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 05:02:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33914 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXKCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:02:20 -0500
Received: by mail-pj1-f68.google.com with SMTP id f2so3900353pjq.1;
        Mon, 24 Feb 2020 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :content-transfer-encoding:date:message-id;
        bh=rB3C6Ui3C2PRhHGdFypVZb4/ATr5XISx7YPQFUhCEqY=;
        b=BuxvF0zexi6lbxhqAVXH0BAnoUGmboKabKjIvKHuvc7pIA3dX8KyIXI5YJO1i/Kpfi
         +HCx5Wyyn+fDaxPoonCPTE8ieRvJeiXsB+e/dsRKnJPaWPJdzeoq4TREyUh2GgBS8W0F
         zx+MysUYWiYdeU6htrT9cRs3u69HRrdo3kjwWj0wakl7htXKqC/XgE54j7EjUVZEPHR3
         L4rZtXUa1NZI3D7PAzpVJxf0GhyW3gjwSjtNawT7/RS7gl2VOhBczHZtSUgm0TXKG6R+
         XU6ylgYkyHaqNFk7HSaAsXn6mVlh01cIplzY2Ql2MPU6mPpMsvBcm3dgLJ/oWEDXibaK
         hGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:content-transfer-encoding:date:message-id;
        bh=rB3C6Ui3C2PRhHGdFypVZb4/ATr5XISx7YPQFUhCEqY=;
        b=jpbwLYnVQ8uONlCkwuV+CG87LPcdmbd8ZXIq3oMIfljXizXyRc8hjUSBiJ0Zf/ltPj
         5d18LpDXkCZ53cbtgAk+wXuQi4DVA8wvW+0hHGv/m2ztYlSlNkf45Kd56qy7TXXCV8JE
         lO7eYaYvJv8O/kpUiEBcSL1mlPwXJdSBJZ6HzfS3Gm3fF9ne/IL1tcrujutGSHHHz0Ie
         nO09V9LeMU/N+BK6OWhxtC8f2EBG6+DEEgP/JAlPQbiUtt3AXpCrK0XRSNFmuOiyIfNx
         FnOst1DOmhLkxprxC71zrEUkFi88r4Iu6+fuTTqMQxPPYAMIktvotgfWdSjqSWcJPDoy
         jxNA==
X-Gm-Message-State: APjAAAV3kwswsADHNZnNqS41sqttYDJHax1TTAbyzka2FooMKAqXxLl8
        GEelk9NYksr+73856wIwaXQ=
X-Google-Smtp-Source: APXvYqzIhuzkSb+8cDBwrTf045i3OCE5ny+FFAShKLaH5fh/PZdiYkTJW5JQcIY00I10hY0FYuZYFg==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr19158028pjw.43.1582538539089;
        Mon, 24 Feb 2020 02:02:19 -0800 (PST)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id e6sm12081336pfh.32.2020.02.24.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:02:18 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1j6AZ7-0006QE-Aw ; Mon, 24 Feb 2020 19:02:17 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: ext2, possible circular locking dependency detected
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20200224090846.GB27857@quack2.suse.cz>
References: <4946.1582339996@jrobl> <20200224090846.GB27857@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24688.1582538536.1@jrobl>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 24 Feb 2020 19:02:16 +0900
Message-ID: <24689.1582538536@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara:
> This is not the right way how memalloc_nofs_save() should be used (you
> could just use GFP_NOFS instead of GFP_KERNEL instead of wrapping the
> allocation inside memalloc_nofs_save/restore()). The
> memalloc_nofs_save/restore() API is created so that you can change the
> allocation context at the place which mandates the new context - i.e., i=
n
> this case when acquiring / dropping xattr_sem. That way you don't have t=
o
> propagate the context information down to function calls and the code is
> also future-proof - if you add new allocation, they will use correct
> allocation context.

Thanks for the lecture about memalloc_nofs_save/restore().
Honestly speaking, I didn't know these APIs and I always use GFP_NOFS
flag. Investigating this lockdep warning, I read the comments in gfp.h.

 * %GFP_NOFS will use direct reclaim but will not use any filesystem inter=
faces.
 * Please try to avoid using this flag directly and instead use
 * memalloc_nofs_{save,restore} to mark the whole scope which cannot/shoul=
dn't
 * recurse into the FS layer with a short explanation why. All allocation
 * requests will inherit GFP_NOFS implicitly.

Actually grep-ping the whole kernel source tree told me there are
several "one-liners" like ...nofs_save(); kmalloc(); ...nofs_restore
sequence.  But re-reading the comments and your mail, I understand these
APIs are for much wider region than such one-liner.

I don't think it a good idea that I send you another patch replaced by
GFP_NOFS.  You can fix it simply and you know much more than me about
this matter, and I will be satisfied when this problem is fixed by you.


J. R. Okajima
