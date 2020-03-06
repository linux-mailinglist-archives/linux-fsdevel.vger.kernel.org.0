Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A224B17C29C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCFQIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:08:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35622 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFQIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:08:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id v15so2095061qto.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bKjjoKS2T/q2pwOzdPEgk28ZK6vwf0Cp/W1ojk+aNxI=;
        b=suzTUJ0rRf5960m06RBzjBCAnb4svatr0bn0EiS4JneAE0k5HF7YYx6h6I/G3u0zz7
         m96ZG9h1Pd3ArvPVXZNxDOX6plQKDTFUja6qgm5dN7KLDiN/kgmTaZbCE/56xH0Ywn6E
         cbYT95e/4A63SjcnU9EOAMIJKduLA9kwkZ8CBqJBG478VWdnD7kIs27f0HPnMnaIP7TS
         BgZ/r2CISnPn+4LMMjcPwbXDKfJnsTiFlVc1r4+0xcGC1ZAgsoaC5bQH5Uu4ECKW/5uy
         Z2/A7XopDa/7rCk5xu5WEGYxIGesVc8vZI7tQ248eHo2Ly6r48AO5tiKN8UP6W9Rjk8l
         +F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKjjoKS2T/q2pwOzdPEgk28ZK6vwf0Cp/W1ojk+aNxI=;
        b=DScFn1CxfJq8Nmio83YwVvqPcTO1lSsdK2hCzvDjWGy56HztI9/RyOYZPLHh2sjT7s
         J621n+gZiOks8L8vFXlkXf9BkUxWmquFeLA8mr1XM9ppUqxRmfbP5/SG0To2Hq5+KcDK
         FxkVBTY/0WjinSOEFkajWh9PBv84XNybT1tH3Jvl/jXCsFvsx3NDZtwvtUP3V7QJlFz2
         2PaexKx6F9hjUgwVRcnuEvTBqvnYi+bdrefRB99yWTl4ijAItu3bt7yqmOl3CDvdsEG3
         tL5QGlHQyr0S+Qowphu/cNZiUq+Yk+4fVm4e/D8kBAQRdgpyiUPQp9ddm2lw8DBq2Tng
         2wlg==
X-Gm-Message-State: ANhLgQ2ZcAGrLP0QzB0H/WkyWuJ4jYC3VItjfaAAMqCvAPfaNZ47KpDa
        J5YPbzoBWekUGtwOBdMPL6ASVg==
X-Google-Smtp-Source: ADFU+vtz2X7WRHc2rQE/mqPpG+Shd2ceCs6iuKNfvLRNmthFTpAKQGUMSM9LnAA3V0GzqXTOmroBUA==
X-Received: by 2002:ac8:6ec1:: with SMTP id f1mr3636659qtv.378.1583510918016;
        Fri, 06 Mar 2020 08:08:38 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p38sm1677376qtf.50.2020.03.06.08.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 08:08:37 -0800 (PST)
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200306155611.GA167883@mit.edu>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <72708005-0810-1957-1e58-5b70779ab6db@toxicpanda.com>
Date:   Fri, 6 Mar 2020 11:08:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306155611.GA167883@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/20 10:56 AM, Theodore Y. Ts'o wrote:
> On Fri, Mar 06, 2020 at 09:35:41AM -0500, Josef Bacik wrote:
>> This has been a topic that I've been thinking about a lot recently, mostly
>> because of the giant amount of work that has been organizing LSFMMBPF.  I
>> was going to wait until afterwards to bring it up, hoping that maybe it was
>> just me being done with the whole process and that time would give me a
>> different perspective, but recent discussions has made it clear I'm not the
>> only one.....
> 
> I suggest that we try to decouple the question of should we have
> LSF/MM/BPF in 2020 and COVID-19, with the question of what should
> LSF/MM/BPF (perhaps in some transfigured form) should look like in
> 2021 and in the future.
> 

Yes this is purely about 2021 and the future, not 2020.

> A lot of the the concerns expressed in this e-mails are ones that I
> have been concerned about, especially:
> 
>> 2) There are so many of us....
> 
>> 3) Half the people I want to talk to aren't even in the room.  This may be a
>> uniquely file system track problem, but most of my work is in btrfs, and I
>> want to talk to my fellow btrfs developers....
> 
>> 4) Presentations....
> 
> These *exactly* mirror the dynamic that we saw with the Kernel Summit,
> and how we've migrated to a the Maintainer's Summit with a Kernel
> centric track which is currently colocated with Plumbers.
> 
> I think it is still useful to have something where we reach consensus
> on multi-subsystem contentious changes.  But I think those topics
> could probably fit within a day or maybe a half day.  Does that sound
> familiar?  That's essentially what we now have with the Maintainer'st
> Summit.
> 
> The problem with Plumbers is that it's really, really full.  Not
> having invitations doesn't magically go away; Plumbers last year had
> to deal with long waitlist, and strugglinig to make sure that all of
> the critical people who need be present so that the various Miniconfs
> could be successful.

Ah ok, I haven't done plumbers in a few years, I knew they would get full but I 
didn't think it was that bad.

> 
> This is why I've been pushing so hard for a second Linux systems
> focused event in the first half of the year.  I think if we colocate
> the set of topics which are currently in LSF/MM, the more file system
> specific presentations, the ext4/xfs/btrfs mini-summits/working
> sessions, and the maintainer's summit / kernel summit, we would have
> critical mass.  And I am sure there will be *plenty* of topics left
> over for Plumbers.
>

I'd be down for this.  Would you leave the thing open so anybody can register, 
or would you still have an invitation system?  I really, really despise the 
invitation system just because it's inherently self limiting.  However I do want 
to make sure we are getting relevant people in the room, and not making it this 
"oh shit, I forgot to register, and now the conference is full" sort of 
situations.  Thanks,

Josef
