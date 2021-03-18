Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1631833FF92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 07:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCRGbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 02:31:13 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33028 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCRGaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:30:55 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMmBG-0073fw-36; Thu, 18 Mar 2021 06:30:50 +0000
Date:   Thu, 18 Mar 2021 06:30:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: improve naming for fsid helpers
Message-ID: <YFLzmkxQA2YW3Bwf@zeniv-ca.linux.org.uk>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
 <20210315145419.2612537-3-christian.brauner@ubuntu.com>
 <20210318062723.GB29726@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318062723.GB29726@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:27:23AM +0100, Christoph Hellwig wrote:
> > -static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
> > +static inline kuid_t idmapped_fsuid(struct user_namespace *mnt_userns)
> >  {
> >  	return kuid_from_mnt(mnt_userns, current_fsuid());
> >  }
> >  
> > -static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
> > +static inline kgid_t idmapped_fsgid(struct user_namespace *mnt_userns)
> >  {
> >  	return kgid_from_mnt(mnt_userns, current_fsgid());
> >  }
> 
> I'm not sure the naming is an improvement.  I always think of
> identity mapped when reading it, which couldn't be further from what
> it does..  But either way comments describing what these helpers do
> would be very useful.

s/idmapped/mapped/?
