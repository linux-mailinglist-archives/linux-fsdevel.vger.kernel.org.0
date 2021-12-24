Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6357D47EA5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 02:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbhLXBff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 20:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245067AbhLXBfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640309732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AW47MdiyK0n8imN2X9qNAgasY2HGNdMX+KQBBxAfgI=;
        b=bumzTv1ezCZCQ5RNJ8ybrXB+7I5so2eKeYAvDIl0MnppwPOwrw8DkSgIzNhr5zJ7Bbk/vb
        779AjlvzLb45H53konFf0p3blcdE/2PY/HV35c4L7EIEsi5wZr4ceRAwLZ7sS8QbpDKDkh
        mK/KyS2+k+FuRx2CzLZgy3LfRbh6aVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-fVezeQVtNUSmsJ7rkb3uYg-1; Thu, 23 Dec 2021 20:35:29 -0500
X-MC-Unique: fVezeQVtNUSmsJ7rkb3uYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE9F91800D50;
        Fri, 24 Dec 2021 01:35:27 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-179.pek2.redhat.com [10.72.12.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78C3B1017E27;
        Fri, 24 Dec 2021 01:35:17 +0000 (UTC)
Date:   Fri, 24 Dec 2021 09:35:12 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Message-ID: <YcUj0EJvQt77OVs2@dhcp-128-65.nay.redhat.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
 <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
 <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d24ea70-e315-beb5-0028-683880c438be@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Guilherme,
On 12/22/21 at 09:34am, Guilherme G. Piccoli wrote:
> On 22/12/2021 08:45, Dave Young wrote:
> > Hi Guilherme,
> > 
> > Thanks for you patch.  Could you add kexec list for any following up
> > patches?  This could change kdump behavior so let's see if any comments
> > from kexec list.
> > 
> > Kudos for the lore+lei tool so that I can catch this by seeing this
> > coming into Andrews tree :)
> 
> Hi Dave, I'm really sorry for not adding the kexec list, I forgot. But I
> will do next time for sure, my apologies. And thanks for taking a look
> after you noticed that on lore, I appreciate your feedback!

Thanks!

> 
> > [...]
> > People may enable kdump crashkernel and panic_print together but
> > they are not aware the extra panic print could cause kdump not reliable
> > (in theory).  So at least some words in kernel-parameters.txt would
> > help.
> >  
> 
> That makes sense, I'll improve that in a follow-up patch, how about
> that? Indeed it's a good idea to let people be sure that panic_print
> might affect kdump reliability, although I consider the risk to be
> pretty low. And I'll loop the kexec list for sure!

If only the doc update, I think it is fine to be another follup-up
patch.

About your 1st option in patch log, there is crash_kexec_post_notifiers
kernel param which can be used to switch on panic notifiers before kdump
bootup.   Another way probably you can try to move panic print to be
panic notifier. Have this been discussed before? 

> 
> Cheers,
> 
> 
> Guilherme

Thanks
Dave

