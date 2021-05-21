Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E238C30D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhEUJ3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbhEUJ3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:29:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C243C0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 02:27:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so10674436plo.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YcLZ8e3MbA7u7iz+gM84yYIhhW/9rebbjr6JcO2AJnA=;
        b=VY0bZl+dQIHuJ3VDs1EkSw5KObGGdc6T0vNdiE3pAdKUJtVyJ+F5vIy+3jlHWJ8VCp
         R/Is13j63P+FXXdBqlGfHXvdhILzzFg2J2jh/egvLPUO278qTb+zA44AppOpy54FxTnV
         SZ4Vp+EFlrfK7fVBH1X0E1wwSg/2Bqw1bVfHLt89Z6OCsZ4WmPrCQre94f2d2+WIahHH
         LXKI+1CHsjxP0M/gFm/Q1ZyJ7/+LwHGMBlH0LBDxeenU7F0eUGaarF3eRNWYCOXo78gl
         Dhs9AEAw3MY3PjIbiDcTIRgq784HUYiBgOWBEpm8ouCPiU1YeNqP2f6xbhP06PZCZIqe
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcLZ8e3MbA7u7iz+gM84yYIhhW/9rebbjr6JcO2AJnA=;
        b=lgfvgIY0eVl02kxZ81NmUp8c2xqUYztoC1FIdQ2FCQ7e/g6MXWIdl7smksah6TJULB
         F2K8bRvg++pphyWNaBg3JiQfVZ99209roMTEfkNvYkdqvUpSuEV4JtAXXToHGwcVlLts
         g/5DfjnuxTwTL+4cGCSevKXYe54mkPv39upDpD6Ff3I6tUY1AGqcVD2KljRMaeQT9bZd
         Kw3r0yMGo8apiCc/wavhxOBzBXaHPTMqR5bsB2zRKkUkXrJ3afRtc1pucTt0hNIm3619
         12/tgcj7+P82W6Us1hg4AM1rY6wZqvd5IGHjK9C9l/A5Qa0xz8L6FtPDkdSfMrGOY8Gk
         MWug==
X-Gm-Message-State: AOAM530XHIkJnc9uhKhq5eihnGQPA86AHXclBZK1s0hqAe1IW8KUjnzT
        gEfg/jNqrMitpzMyawFivcmg2D8sygQZMQ==
X-Google-Smtp-Source: ABdhPJxcto2Xjz9wGX7cRgqbAPaN3E4FHGFnPienYZqIYptyiiU/nM9Hyno3/bxj3/RxgqG+T0RRyQ==
X-Received: by 2002:a17:90a:b388:: with SMTP id e8mr10003228pjr.167.1621589224321;
        Fri, 21 May 2021 02:27:04 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:42b2:c084:8468:626a])
        by smtp.gmail.com with ESMTPSA id x9sm3925421pfd.66.2021.05.21.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 02:27:03 -0700 (PDT)
Date:   Fri, 21 May 2021 19:26:50 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying function
Message-ID: <YKd82mgLHaWehNID@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <24c761bd0bd1618c911a392d0c310c24da7d8941.1621473846.git.repnop@google.com>
 <CAOQ4uxjK-0nC5OHGQ5ArDuNq_3pFKfyjBmUfCqv=kAsq5y8KUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjK-0nC5OHGQ5ArDuNq_3pFKfyjBmUfCqv=kAsq5y8KUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 04:59:23PM +0300, Amir Goldstein wrote:
> On Thu, May 20, 2021 at 5:11 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > The copy_info_to_user() function has been repurposed with the idea to
> 
> Sorry I gave comment on patch 5 before I knew you repurposed
> copy_info_to_user().
> Perhaps it would be better to give a non ambiguous name like
> copy_info_records_to_user() or

^ I like this.

> copy_fid_info_records_to_user() and leave pidfd out of this helper.
> If you do wish to keep pidfd copy inside this helper and follow my
> suggestion on patch 5 you will have to pass in pidfd as another argument.

I'd like to keep all the info record related copying branching out
from a single helper, which in this case will now be
copy_info_records_to_user().

/M
