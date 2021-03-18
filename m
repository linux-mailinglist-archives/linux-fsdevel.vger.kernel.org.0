Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8F33FF88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 07:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCRG1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 02:27:25 -0400
Received: from verein.lst.de ([213.95.11.211]:40233 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhCRG1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:27:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80E3268C65; Thu, 18 Mar 2021 07:27:23 +0100 (CET)
Date:   Thu, 18 Mar 2021 07:27:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: improve naming for fsid helpers
Message-ID: <20210318062723.GB29726@lst.de>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com> <20210315145419.2612537-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315145419.2612537-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
> +static inline kuid_t idmapped_fsuid(struct user_namespace *mnt_userns)
>  {
>  	return kuid_from_mnt(mnt_userns, current_fsuid());
>  }
>  
> -static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
> +static inline kgid_t idmapped_fsgid(struct user_namespace *mnt_userns)
>  {
>  	return kgid_from_mnt(mnt_userns, current_fsgid());
>  }

I'm not sure the naming is an improvement.  I always think of
identity mapped when reading it, which couldn't be further from what
it does..  But either way comments describing what these helpers do
would be very useful.
