Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08842D1430
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLGO6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 09:58:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:51078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgLGO6U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:58:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC3ABAC2E;
        Mon,  7 Dec 2020 14:57:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C37ACDA7BA; Mon,  7 Dec 2020 15:56:03 +0100 (CET)
Date:   Mon, 7 Dec 2020 15:56:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: remove cow fixup related code
Message-ID: <20201207145603.GA6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201207071352.106160-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207071352.106160-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:13:52PM +0800, Qu Wenruo wrote:
> >From the initial merge of btrfs, there is always the mystery cow fixup.

For the record, the code needs to stay for because it's still needed.
Though finding the exact point where it happens on intel architectures
is not easy, it's required on s390 because of the separate page bits
tracking at least. How exactly it works and why the code exists is left
as an exercise to the reader.
