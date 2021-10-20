Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49686434DF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJTOkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:40:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54874 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTOkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:40:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CC991F770;
        Wed, 20 Oct 2021 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634740687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4iF8kBLMjZEbLeHRO6aMiCZ4D7LMYZJwNThdpCCqN4=;
        b=I8TLdMZDMgOInHkg9ocqAfIcdQrMCkuSnKwxHCzaH0rZcrCRwg+V60A23wU1ArIOcKTkwo
        H7ZMEv2yH7dXg+TNU4xxoAoZenINYl54loPiJzM4j0njGVv+mHnYKwBrvfYDkVqc9DhDju
        otC8ukP4FHOOIaMhR6YyYT/Ed3/NDRU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBAB013B55;
        Wed, 20 Oct 2021 14:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JnMzL84pcGGtIAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Oct 2021 14:38:06 +0000
Subject: Re: [PATCH v11 04/10] btrfs-progs: receive: add send stream v2 cmds
 and attrs to send.h
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <5b7301ccf0ac841e02ae736138f661630093603e.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <556c659f-cf48-8bd1-3c92-661b8fd03fd5@suse.com>
Date:   Wed, 20 Oct 2021 17:38:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5b7301ccf0ac841e02ae736138f661630093603e.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 
> Send stream v2 adds three commands and several attributes associated to
> those commands. Before we implement processing them, add all the
> commands and attributes. This avoids leaving the enums in an
> intermediate state that doesn't correspond to any version of send
> stream.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
