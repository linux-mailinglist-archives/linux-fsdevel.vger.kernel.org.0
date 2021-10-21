Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F11436205
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhJUMrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58724 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJUMrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2AD45219C3;
        Thu, 21 Oct 2021 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634820293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vH7DlBidxV3txgKTgmSehqSbMuv8Lc1tQ+bOSpNUDDs=;
        b=aOAakLYasZIlJD1zLJxCgNE4is1Wk189EsV9qZ5VuQ4/nA1WjAVZsA8lLJ9DY10MOaICu3
        5/DENTAaAg1oMP1dzLbrzN5OOJBa49Eo0AV/oVzRKnlVynMyfdRsoXlOYvINKju+19Sf/a
        6Mglm62zGKFscZjSF9ndN2zbMOEP5Ow=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D21AD13AA1;
        Thu, 21 Oct 2021 12:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KqjEMMRgcWEjDQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 12:44:52 +0000
Subject: Re: [PATCH v11 04/14] btrfs: add ram_bytes and offset to
 btrfs_ordered_extent
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <9169c58574fa559e6633cca7e60fe32cd161003a.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <66c2c57b-5f67-f05f-5660-b60b649b2f4d@suse.com>
Date:   Thu, 21 Oct 2021 15:44:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9169c58574fa559e6633cca7e60fe32cd161003a.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:00, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, we only create ordered extents when ram_bytes == num_bytes
> and offset == 0. However, RWF_ENCODED writes may create extents which

Change RWF_ENCODED to simply encoded as we no longer rely on RWF flags,
same thing for the changelog in the next patch.

<snip>
