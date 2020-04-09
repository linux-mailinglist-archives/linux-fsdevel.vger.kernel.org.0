Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA21A37E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDIQWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 9 Apr 2020 12:22:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:60346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgDIQWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:22:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8DD00AC1D;
        Thu,  9 Apr 2020 16:22:22 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/mounts: add cursor
In-Reply-To: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
References: <20200409141619.GF28467@miu.piliscsaba.redhat.com>
Date:   Thu, 09 Apr 2020 18:22:21 +0200
Message-ID: <87369ceiiq.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:
>  
> +static inline void lock_ns_list(struct mnt_namespace *ns)
> +{
> +	spin_lock(&ns->ns_lock);
> +}
> +
> +static inline void unlock_ns_list(struct mnt_namespace *ns)
> +{
> +	spin_unlock(&ns->ns_lock);
> +}
> +

You could add __acquires sparse annotations for those functions. See:

https://www.kernel.org/doc/html/v5.6/dev-tools/sparse.html#using-sparse-for-lock-checking

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
