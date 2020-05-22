Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC631DDF0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 06:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgEVE4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 00:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEVE4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 00:56:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5650AC061A0E;
        Thu, 21 May 2020 21:56:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so4380257pjs.5;
        Thu, 21 May 2020 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUbHfPNmTbu4ctyPCNklCkDL8Qa0yGq7Hose+vNxUdI=;
        b=HSwpbmpN/NsMlf8GRobtYw4MbqLnCFOmBsW9Coz/cHTxIrITp0Sbk2T+YtZz/+MInO
         bUmzGD/8ya32drYpzuNGs7PHIkgAfF6iRsWlQZOstMlslCS/Hkq4M20H/3v40T+PS1WU
         Co01HEJHU/O8QfANYlmNo84IEYbyNfG0n+zBwIw+WVHkiMFpsKPhP3WjhGG3wod8jIcI
         71For32tEZwABqW/Jby+5vAzMMq1T2X/KSb/azM+BZCgmG1WO8dFAS7RgcU46Tzj7U4R
         aV+4OdAIau35x5GD9gmNhm/P4aDR3MY3PLj7mUO1w/aT9jS0Hv0mbrRy9r/PvyeO2/WQ
         P+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUbHfPNmTbu4ctyPCNklCkDL8Qa0yGq7Hose+vNxUdI=;
        b=JVT+cZ5cq2nFkAjkPunr0Tkbm6aZIEEhiiP5UTPOvFKI/qJvx8stoejwXgA7XRMVDD
         HCd1sBa2FLQkLy6aDTaaQ84cU+De5+RMy1kRxHbnBpo274vKJSYDVyAK097jzlUs4WuB
         lmPRy9EKSLkL5VtuodK2TodjeMqD5MWru9r2q+SSE7ZZh92tHGGYKfWm+9mMk5cAa9Hm
         XKWBWwKv+BYbuG3arvnqjrPqoNpV737rYHHupwj9Wi/osOCuKD1ei1tf+rQtqB1pqbhH
         lajbiG0QDG5mTaA67oTX1eEXxfO4fZ/uX6ywIELkF/xGPtmrkHEqx1dqKBX5rjUQggRD
         ecJQ==
X-Gm-Message-State: AOAM533J66cbTv4OKwy9SN0iyC3iWZEIFVljk4Jxfx4cSJOd5J4W2d9G
        gQXhzsnuZVeW3TfP/08PCRW1hIgjIiQ=
X-Google-Smtp-Source: ABdhPJyazPRDMrtnKsAL0hgIQjLDKmHhDTs11sSstZoPCTQMV4mlMgCCBg75JfoZ1ZurURWSqpqI1Q==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13mr2589481pls.210.1590123383741;
        Thu, 21 May 2020 21:56:23 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id fw4sm5668348pjb.31.2020.05.21.21.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 21:56:23 -0700 (PDT)
Date:   Fri, 22 May 2020 12:56:15 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-ext4@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200522045615.y3vhtfdbmpndzwvp@xzhoux.usersys.redhat.com>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200519024311.7bkxi2fkxboon2ig@xzhoux.usersys.redhat.com>
 <20200521060833.855415204F@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521060833.855415204F@d06av21.portsmouth.uk.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritesh,

On Thu, May 21, 2020 at 11:38:32AM +0530, Ritesh Harjani wrote:
> Hello Murphy,
> 
> On 5/19/20 8:13 AM, Murphy Zhou wrote:
> > On Thu, Apr 23, 2020 at 04:17:52PM +0530, Ritesh Harjani wrote:
> > > Hello All,
> > > 
> > > Here are some changes, which as I understand, takes the right approach in fixing
> > > the offset/length bounds check problem reported in threads [1]-[2].
> > > These warnings in iomap_apply/ext4 path are reported after ext4_fiemap()
> > > was moved to use iomap framework and when overlayfs is mounted on top of ext4.
> > > Though the issues were identified after ext4 moved to iomap framework, but
> > > these changes tries to fix the problem which are anyways present in current code
> > > irrespective of ext4 using iomap framework for fiemap or not.
> > 
> > Ping?
> 
> It's superseded by below mentioned patch series.
> Please follow below thread.
> https://lore.kernel.org/linux-ext4/20200520032837.GA2744481@mit.edu/T/#t

Great. Thanks for the info!

> 
> -ritesh

-- 
Murphy
