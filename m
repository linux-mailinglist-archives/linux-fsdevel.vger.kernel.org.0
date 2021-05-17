Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE9383AEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhEQROm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhEQROm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 13:14:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B6C061573;
        Mon, 17 May 2021 10:13:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id v9so8564880lfa.4;
        Mon, 17 May 2021 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YW4kTCwrNjfUZX+2cYxMOpD57e76pTrkb3RiCqgyKsk=;
        b=lWXGunBWmMsAvV+iz1HoCTaPgLQVpJb+B+13kjqKRtKAh+UmQ/jsQFgv1UWSpHHNDb
         /dpIgvRlx8zPjSUoMojDwMLCCbs99v1DB/weEkEHvm2mLmnXd3n5NChp2MOBhy67lAga
         tFP1+4jwxulE/QhSOPAH6OMV+ZA1f/OWwifM+mB3kdyl/A+37fOANO8DzQwirEoK/bMi
         Ku6LXV2BYPGSI4OXb73w+pyngS4E+LtGFmzt/NUXDyPP6uJ+oH9k1dsTesPcgbVOX/Lq
         PJjmGfbuI9OIJhIJuGqqRsPD0WeUQlfgr963ThtCJT+jCI2Og5oCBHAcepiEuY/wHIEp
         YElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YW4kTCwrNjfUZX+2cYxMOpD57e76pTrkb3RiCqgyKsk=;
        b=WTrYk7KiFuTIK48+oEH7+76eIvTUA5ugnccVRh8d2tuYOC9cVhzsY1GBiiLufXlhA6
         LxqqkW5s2vYLY06x8CyqdKzI0WqWzjbGhrtvxEjDPRiPfqlvicbFrHECXGQ7ToTDVVIF
         bXVVooHkh9pyZlfsp9lb2iieC8dCqZZo0KziHrdSHMgyKrDmUm4seDbDTWmkuGAK30vH
         FSJ/hoVMQWFjsfc2cLG4OzO5rsXj9jTeLUr538vAOjLJu1T1UfxWj9oNXP4XEPphwzc+
         mUHTs7yXjw4PC6yRnwwRxeXvDRqadSvTE9wBioYcGHgVAsSvu4hzczHDVomRWlbvrC/7
         Zg4Q==
X-Gm-Message-State: AOAM5312FfyOFBiIhDeE1U9kkWW93/GZWM9jhd3ghA9A+y543DXeN9JI
        1Nxyg+aWi5QnBluUOslzMVw4BxYeTpHcr/1pnZg=
X-Google-Smtp-Source: ABdhPJyxx5A1Uh88zOG44o1mnOFK+YqAPDU8NJMfBhs5d5SI4RTaeEDjDx6YJlSyVN/giyQsdG/3z9aCEsdmn7DfgDA=
X-Received: by 2002:a05:6512:33d0:: with SMTP id d16mr652121lfg.184.1621271603832;
 Mon, 17 May 2021 10:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <202105110829.MHq04tJz-lkp@intel.com> <a022694d-426a-0415-83de-4cc5cd9d1d38@infradead.org>
 <MN2PR21MB15184963469FEC9B13433964E42D9@MN2PR21MB1518.namprd21.prod.outlook.com>
In-Reply-To: <MN2PR21MB15184963469FEC9B13433964E42D9@MN2PR21MB1518.namprd21.prod.outlook.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 17 May 2021 12:13:12 -0500
Message-ID: <CAH2r5mswqB9DT21YnSXMSAiU0YwFUNu0ni6f=cW+aLz4ssA8rw@mail.gmail.com>
Subject: Fwd: [EXTERNAL] Re: ioctl.c:undefined reference to `__get_user_bad'
To:     Randy Dunlap <rdunlap@infradead.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arm-linux-gnueabi-ld: fs/cifs/ioctl.o: in function `cifs_dump_full_key':
>>> ioctl.c:(.text+0x44): undefined reference to `__get_user_bad'
>

<snip>

># CONFIG_MMU is not set
>
>and arch/arm/include/asm/uaccess.h does not implement get_user(size 8 bytes)
> for the non-MMU case:

I see another place in fs/cifs/ioctl.c where we already had been doing
a get_user() into a u64 - any idea what you are supposed to do
instead?  Any example code where people have worked around this.

-- 
Thanks,

Steve
