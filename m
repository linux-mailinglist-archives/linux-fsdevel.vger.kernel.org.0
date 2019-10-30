Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601F8E9AFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 12:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJ3Lo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 07:44:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:57172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfJ3Lo0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:44:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35BB4AC45;
        Wed, 30 Oct 2019 11:44:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BC6ADA783; Wed, 30 Oct 2019 12:44:32 +0100 (CET)
Date:   Wed, 30 Oct 2019 12:44:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: affs: fix a memory leak in affs_remount
Message-ID: <20191030114430.GE3001@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Navid Emamdoost <navid.emamdoost@gmail.com>, emamd001@umn.edu,
        smccaman@umn.edu, kjlu@umn.edu, David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>, Kees Cook <keescook@chromium.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191002092221.GJ2751@suse.cz>
 <20191002215242.14317-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002215242.14317-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:52:37PM -0500, Navid Emamdoost wrote:
> In affs_remount if data is provided it is duplicated into new_opts.
> The allocated memory for new_opts is only released if pare_options fail.
> But the variable is not used anywhere. So the new_opts should be
> removed.
> 
> Fixes: c8f33d0bec99 ("affs: kstrdup() memory handling")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	-- fix typo
> Changes in v3:
> 	-- remove the call to kstrdup, as new_opts is not used anymore.

Added it to affs queue. There are still typos in the changelog and this
was pointed out, and v3 lacks the explanations I replied to v2.  I'll
fix it up.
