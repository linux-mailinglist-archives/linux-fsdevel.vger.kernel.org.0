Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C3406502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 03:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhIJBVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 21:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhIJBVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:21:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3220C014A48
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 18:05:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oc9so270386pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jpINwl9x85gzN+OIwHyro5eublOc2ZGCIrp2a+ft6ec=;
        b=cF7RI+iuYj53D87orFMgzv0cI8Bu3SqOdYz8IfvOe6ONVXZ8GdWJzU3NjNGlBoCw3o
         IQDxNUvTQPQKS8y2p0ZMz+gC97d9/VQYTXnr5yZQ4kl25I9WMt5Smumi6hwY0FEIUTBc
         Ha87jJs8bvhOkonpl2vnrh4MUHfivxtXv2026EnbrKacd4RHTeCYgrrVhf6n8qeeyS6W
         +kFrut2EznQ4nbVyEG2DE9YyU2GNT4WnbF1yNARAd3xwZyNpMDXItCS5iCnneIlEWxsC
         VOWRzo1QiKiAY8KWbIAhxedZ4s40VSJb35MssRde/RfpYMuSK9y/tgBjUP/n4L3z6oa4
         IM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jpINwl9x85gzN+OIwHyro5eublOc2ZGCIrp2a+ft6ec=;
        b=DinbxhnvxbCE1INzT4X8RG2tMSsjkzVFG553EDlIqbfm5A4FSYoJZNCazQdBQU4TDA
         39m3YCQBuFf/7CPM0RUCE8UMx0ukf5hBJLa67VgPe2sAhICNkVPEIomk3R+I3zPjD4mP
         SMVbDrfCiouvrj98K03nrO0kUFks06jFhC++fLfrWfKuZOo0wpS78qGY6BMqixRveuEm
         x3H3yQz2w856tpodbzZ9DVgf6eERls77ysxj8ZNsLmiHb+VwqVvxEcTjMy+j13+cN9oS
         1gw4i61OQbmRXQubkBOV95RDNUCbOKd3bO7pIjmoJUbY03ursTEH7Wfowv5Vfn8+9/RK
         NzCQ==
X-Gm-Message-State: AOAM530Ot+e0j5MqXiklZFjQlsFyLCX63HHYJ3S5E+DNBrMYQpEadZky
        T5z5H710bYEsbBzv8fFTizA=
X-Google-Smtp-Source: ABdhPJz53d+yJEPC39aInAewnaZOIv0gMd8huWH9CWV1hG5ppMnyHx9lOV110vyi7hOIX/uXq2r45Q==
X-Received: by 2002:a17:902:8491:b0:13a:16dc:f32c with SMTP id c17-20020a170902849100b0013a16dcf32cmr5215543plo.55.1631235948341;
        Thu, 09 Sep 2021 18:05:48 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r23sm3307467pjo.3.2021.09.09.18.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 18:05:47 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:05:39 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [regression] fsnotify fails stress test since
 fsnotify_for_v5.15-rc1 merged
Message-ID: <20210910010539.zfpxxwwrepqyqreg@xzhoux.usersys.redhat.com>
References: <20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com>
 <CAOQ4uxhnnG6g29NomN_MLvfk9Cf6gEfaOkW0RuXDCNREhmofdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhnnG6g29NomN_MLvfk9Cf6gEfaOkW0RuXDCNREhmofdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 02:00:04PM +0300, Amir Goldstein wrote:
> On Tue, Sep 7, 2021 at 9:33 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >
> > Hi,
> >
> > Since this commit:
> >
> > commit ec44610fe2b86daef70f3f53f47d2a2542d7094f
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Tue Aug 10 18:12:19 2021 +0300
> >
> >     fsnotify: count all objects with attached connectors
> >
> >
> >
> >
> > Kernel fsnotify can't finish a stress testcase that used to pass quickly.
> >
> > Kernel hung at umount. Can not be killed but restarting the server.
> >
> > Reproducer text is attached.
> >
> 
> Hi Murphy,
> 
> Thank you for the detailed report.
> I was able to reproduce the hang and the attached patch fixes it for me.
> Cloud you please verify the fix yourself as well?

That's quick. You rock Amir. Testing.
> 
> This is a good regression test.
> Did you consider contributing it to LTP?
> I think the LTP team could also help converting your reproducer to
> an LTP test (CC: Petr).

Ya, this is part of a stress test I maintained. Post to LTP is on
my todo list, for a long time.. I'll work on this.

> 
> Thanks,
> Amir.

-- 
Murphy
