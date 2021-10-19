Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356CC434034
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 23:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhJSVN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 17:13:26 -0400
Received: from namei.org ([65.99.196.166]:52438 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhJSVN0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:13:26 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 17:13:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 3A5781C2;
        Tue, 19 Oct 2021 20:52:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 3A5781C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1634676775; bh=eJ38SycwOWDCZsBfSsnUj9RXqKdsL9o4kYObW0CKim0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ap83rxBCm0keV5NBaLe8KLpMnIwqcHEq9pgLJI793OJ5Of4PzaUjTwC7Hx5QHGtsH
         MEK3P9I8WrBZfxX4R/jEcUYZTcTsZxIorz4cKYTfWtAr7yDMIoIFMuIcTchwBChlmk
         /Zn8v2W44qp6Lts4z9QzcOjQyFUsW82uuihq8CQI=
Date:   Wed, 20 Oct 2021 07:52:55 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Vivek Goyal <vgoyal@redhat.com>
cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>, dwalsh@redhat.com,
        jlayton@kernel.org, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        serge@hallyn.com
Subject: Re: [PATCH v2] security: Return xattr name from
 security_dentry_init_security()
In-Reply-To: <YW1qJKLHYHWia2Nd@redhat.com>
Message-ID: <3bd86fa3-b3b0-754f-25a5-5e4f723babe4@namei.org>
References: <YWWMO/ZDrvDZ5X4c@redhat.com> <YW1qJKLHYHWia2Nd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Oct 2021, Vivek Goyal wrote:

> Hi James,
> 
> I am assuming this patch will need to be routed through security tree.
> Can you please consider it for inclusion.
> 

I'm happy for this to go via Paul's tree as it impacts SELinux and is 
fairly minor in scope.


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

