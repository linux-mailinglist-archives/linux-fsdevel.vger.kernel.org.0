Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3A240831
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgHJPKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:10:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHJPKb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:10:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41473AC82;
        Mon, 10 Aug 2020 15:10:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B4C1DA7D5; Mon, 10 Aug 2020 17:09:29 +0200 (CEST)
Date:   Mon, 10 Aug 2020 17:09:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: delete duplicated words + other fixes
Message-ID: <20200810150929.GB2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200805024834.12078-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805024834.12078-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:48:34PM -0700, Randy Dunlap wrote:
> Delete repeated words in fs/btrfs/.
> {to, the, a, and old}
> and change "into 2 part" to "into 2 parts".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, added to misc-next.
