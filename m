Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1658E4DAEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfFTUHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 16:07:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33716 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfFTUHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:07:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so7635088wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RfU1Hknmojux+IVGlJVcimM6SZLRtUFMkSWlx6MpZm8=;
        b=f9xwjH92YLxEqLA2Gac3BLzW8ln/+WixuL2e++rz/p9b0wcGXJ4oiFtXjP8PP/7lFV
         xANSmHAqcDdV4YifC7O6dxsJnklI3dZGWZHWrlKQG4glqdL32g+ZmeoonwzCyNqjxtRs
         /degJ+zRJVonRXCzcv02o0XmPfP9tzNGI7P0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RfU1Hknmojux+IVGlJVcimM6SZLRtUFMkSWlx6MpZm8=;
        b=unYjwgkyav2OUHj/0hL21HJm7+eaf+H7L7hwbRzfBuaq+Vrfo6bZBYJC/CHY5Q2qEe
         HYUsoMUQA94fDzQn7kVPNrFhj3GLJc3K/nw52nx9osf1AVKmoBVOhw7GogPCLWGlUP69
         +Kua5MCYCUWhlFvF5Qs17Yz2PKow3yqLdYdbYs6ZPc5g41yQO2a9cGagsdnA0GsG9Tb+
         x4udJBj41+gp3RlVOrKZDmHQi4oGoVLNXxCo+cXbQsocFJb6bs5z0iHoFR8F0u9Oazq/
         HsliuRVie8ogF4xZZxKxAM0il4QtKJfslB76sbqnnnNOW+F3f3kgkhwcQlHkq9b8PQ8o
         KDIQ==
X-Gm-Message-State: APjAAAWOqDQqFwy+ywcBw2D7aCQ6XHZcReohrLJ1zeLJOqfTk/82ZeZy
        WVooJx+7JgQ2jAcUqd46sed+hCnkBPo=
X-Google-Smtp-Source: APXvYqxMDgTpOVzO9SzO9IASeizCj4iR2lNwOplQUQwZH4plnJXEy+o+aQV0j09AVb2qCyKmBsvqBw==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr795818wmf.19.1561061266686;
        Thu, 20 Jun 2019 13:07:46 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id c15sm615441wrd.88.2019.06.20.13.07.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:07:45 -0700 (PDT)
Date:   Thu, 20 Jun 2019 22:07:37 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.2-rc6
Message-ID: <20190620200737.GA10138@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.2-rc6

Just a single revert, fixing a regression in -rc1.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      Revert "fuse: require /dev/fuse reads to have enough buffer capacity"

---
 fs/fuse/dev.c | 10 ----------
 1 file changed, 10 deletions(-)
