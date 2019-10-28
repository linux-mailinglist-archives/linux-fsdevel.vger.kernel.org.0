Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4DE761A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbfJ1Q2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 12:28:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729399AbfJ1Q2k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:28:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5C5FB17D;
        Mon, 28 Oct 2019 16:28:38 +0000 (UTC)
Date:   Mon, 28 Oct 2019 11:28:35 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Ian Kent <raven@themaw.net>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Don't propagate automount
Message-ID: <20191028162835.dtyjwwv57xqxrpap@fiona>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
 <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
 <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
 <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
 <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
 <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
 <20190927161643.ehahioerrlgehhud@fiona>
 <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
 <20191001190916.fxko7vjcjsgzy6a2@fiona>
 <5117fb99760cc52ca24b103b70e197f6a619bee0.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5117fb99760cc52ca24b103b70e197f6a619bee0.camel@themaw.net>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ian,

On 10:14 02/10, Ian Kent wrote:
> On Tue, 2019-10-01 at 14:09 -0500, Goldwyn Rodrigues wrote:
<snip>

> Anyway, it does sound like it's worth putting time into
> your suggestion of a kernel change.
> 
> Unfortunately I think it's going to take a while to work
> out what's actually going on with the propagation and I'm
> in the middle of some other pressing work right now.


Have you have made any progress on this issue?
As I mentioned, I am fine with a userspace solution of defaulting
to slave mounts all of the time instead of this kernel patch.


-- 
Goldwyn
