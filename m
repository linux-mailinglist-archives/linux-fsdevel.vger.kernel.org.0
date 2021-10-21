Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAA6436405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhJUOYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:24:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41684 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUOYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:24:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E992217BA;
        Thu, 21 Oct 2021 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634826142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl/iAuk9CGzA31xtE/NzBKo8caNqQsbcfKX2R8KPqrk=;
        b=PQfIAHOZXyJ4BvF0ZGUm/9HYP/HSBP9/GzZ5YS86GpGdgoJvmW7rFfw8Bn/DFrXU8JMf5A
        0BXWUeodFqBY2Dc3APLI5T5ZMQGTt3n8+d4Aw0rM0J3Dkz/6VF8mr1095kUzxbeWr168Br
        gdtSTgE2aFglHfbr3QJd03ShMzSMIkA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB3913ACC;
        Thu, 21 Oct 2021 14:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OW33L513cWE4OgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 14:22:21 +0000
Subject: Re: [PATCH v11 08/10] btrfs-progs: receive: process setflags ioctl
 commands
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <45b2c23b6ed4fb3d6e9e9f3fbe4d6a245df3a612.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8db5b80b-2f87-51a0-8718-697fb031e0b6@suse.com>
Date:   Thu, 21 Oct 2021 17:22:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <45b2c23b6ed4fb3d6e9e9f3fbe4d6a245df3a612.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 
> In send stream v2, send can emit a command for setting inode flags via
> the setflags ioctl. Pass the flags attribute through to the ioctl call
> in receive.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>


Revewed-by: Nikolay Borisov <nborisov@suse.com>

Same remark about the missing kernel implementation.
