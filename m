Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1C483B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFQNRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 09:17:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfFQNRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:17:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E245CAE87;
        Mon, 17 Jun 2019 13:17:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C970DA8D1; Mon, 17 Jun 2019 15:18:37 +0200 (CEST)
Date:   Mon, 17 Jun 2019 15:18:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Proper packed attribute usage?
Message-ID: <20190617131837.GE19057@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f24ea8b6-01ff-f570-4b9b-43b4126118e6@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:06:22PM +0800, Qu Wenruo wrote:
> And for a btrfs specific question, why we have packed attribute for
> btrfs_key?
> I see no specific reason to make a CPU native structure packed, not to
> mention we already have btrfs_disk_key.

For that one there's no reason to use packed and we can go further and
reorder the members so that the offset is right after objectid, ie. both
at aligned addresses.  I have a patch for that but I still need to
validate that.
