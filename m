Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAF8406505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 03:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhIJBWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 21:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIJBWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:22:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6375C008688
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 18:06:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w6so97831pll.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjeVqqBD8x4g35fV4J040UbndaWlY1mfmiNNEP1GPb4=;
        b=VnEaAD9lvy65kyG1J7v669YwTPTbdUJeZR+141aqnngTDk+o0ejojZ7fkcmzYgmQ1S
         KJqI0XSVhAfzWo64MNFo+HriendBxUayam1AsyGc4sQS0C2x4miGDhAAUphaDAuZvzR1
         psjL5uHxxkFqq1lhbYS/r71enUZ/0cM3DaGiW0wEZ8Ejx6MO3yaiJpTE0fsAw12O9duu
         41QMZeYvXsaGTOibwE4mrzGwsVc1lyE+8EzVVrP/xFHsOiPhRzkGbhqqTLsBvYkAzknr
         FiyVgB52RoI94ie9nr/3tJ2UWdMBucpj4j1hscPwW4LYGmWPxl7iSMpTfPcKS9N+N+QS
         oEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjeVqqBD8x4g35fV4J040UbndaWlY1mfmiNNEP1GPb4=;
        b=N4R36AGkUs8evCujyLScjW2y/fbHIkwPeeRRLA2Ib3MtS65U4n1zOFqJMcfTV4aKHa
         aEbJTW9AwIV/+4x3AAFV4Q1OmX0QSUEGmImIgSqDmKHszUQ2xPxNhVEN19uOmIvOSy31
         IsNb6AFmymqQK11pIcXKU7DBA97RdCgovv6oGPPLrfwpgq7wwzmzXYagaQparSZJS0D8
         dowglMaTlLv73HG9+BwkheRP674izfqQiHAMMOahBOwD+GZwP+L/CpYm1gFniyXmo5V/
         GUTgr4bBC1JLZILk+9k4EGNkJYJTjPRvSzreASz3TyFXRZq/VD/kFZHXiLXUUcLJjW6+
         LBUw==
X-Gm-Message-State: AOAM530nFO0Zb+4FewPTu09cNO/1dcJgLHUY427IbiOeUl4vTPq38eik
        TX1M9PNw+LI1YC80lqUHHVg=
X-Google-Smtp-Source: ABdhPJx0zMODx+3ljF0e5vsWZyu5fIcAkqeypGHJY2TGzv9VBzxa32TBWdr+QVMNYxhSek0FZ3NsBQ==
X-Received: by 2002:a17:903:248:b0:138:d607:a8f4 with SMTP id j8-20020a170903024800b00138d607a8f4mr5092618plh.75.1631236016145;
        Thu, 09 Sep 2021 18:06:56 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i7sm3626885pgd.56.2021.09.09.18.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 18:06:55 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:06:46 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [regression] fsnotify fails stress test since
 fsnotify_for_v5.15-rc1 merged
Message-ID: <20210910010646.amvdempc3lumqbpj@xzhoux.usersys.redhat.com>
References: <20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com>
 <CAOQ4uxhnnG6g29NomN_MLvfk9Cf6gEfaOkW0RuXDCNREhmofdw@mail.gmail.com>
 <YTnr3gpG44IEjEkf@pevik>
 <YTnsfdRFofJfIBal@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTnsfdRFofJfIBal@pevik>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:14:05PM +0200, Petr Vorel wrote:
> > > On Tue, Sep 7, 2021 at 9:33 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> 
> > > > Hi,
> 
> > > > Since this commit:
> 
> > > > commit ec44610fe2b86daef70f3f53f47d2a2542d7094f
> > > > Author: Amir Goldstein <amir73il@gmail.com>
> > > > Date:   Tue Aug 10 18:12:19 2021 +0300
> 
> > > >     fsnotify: count all objects with attached connectors
> 
> 
> 
> 
> > > > Kernel fsnotify can't finish a stress testcase that used to pass quickly.
> 
> > > > Kernel hung at umount. Can not be killed but restarting the server.
> 
> > > > Reproducer text is attached.
> 
> 
> > > Hi Murphy,
> 
> > > Thank you for the detailed report.
> > > I was able to reproduce the hang and the attached patch fixes it for me.
> > > Cloud you please verify the fix yourself as well?
> 
> > > This is a good regression test.
> > > Did you consider contributing it to LTP?
> > > I think the LTP team could also help converting your reproducer to
> > > an LTP test (CC: Petr).
> 
> > @Murphy: yes, please contribute that to LTP. There are already fanotify tests [1],
> > here is the C API [2] and shell API [3] (if needed, it should be enough to write
> > it just in C). If you have any questions, don't hesitate ask on LTP ML and Cc
> > me.
> 
> I see you've contributed to LTP already :).

Ya :) Thank you for the links. That's very helpful!

> 
> Kind regards,
> Petr
> 
> > @Amir: thanks!
> 
> > Kind regards,
> > Petr
> 
> > [1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/syscalls/fanotify/
> > [2] https://github.com/linux-test-project/ltp/wiki/C-Test-API
> > [3] https://github.com/linux-test-project/ltp/wiki/Shell-Test-API
> 
> > > Thanks,
> > > Amir.
> 
> > > From 14d3c313062dfbc86b3d2c4d7deec56a096432f7 Mon Sep 17 00:00:00 2001
> > > From: Amir Goldstein <amir73il@gmail.com>
> > > Date: Thu, 9 Sep 2021 13:46:34 +0300
> > > Subject: [PATCH] fsnotify: fix sb_connectors leak
> 
> > > Fix a leak in s_fsnotify_connectors counter in case of a race between
> > > concurrent add of new fsnotify mark to an object.
> 
> > > The task that lost the race fails to drop the counter before freeing
> > > the unused connector.
> 
> > > Fixes: ec44610fe2b8 ("fsnotify: count all objects with attached connectors")
> > > Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > Link: https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/mark.c | 1 +
> > >  1 file changed, 1 insertion(+)
> 
> > > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > > index 95006d1d29ab..fa1d99101f89 100644
> > > --- a/fs/notify/mark.c
> > > +++ b/fs/notify/mark.c
> > > @@ -531,6 +531,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
> > >  		/* Someone else created list structure for us */
> > >  		if (inode)
> > >  			fsnotify_put_inode_ref(inode);
> > > +		fsnotify_put_sb_connectors(conn);
> > >  		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
> > >  	}

-- 
Murphy
