Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD3EE48F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDQVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 11:21:53 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60952 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDQVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1572884512; x=1604420512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGnQPXWoTcvG1tC3eEcv7j0tgV54CAl4lGKMO+R9B4Y=;
  b=USbRRchrA6MKInbnRNlMvLbyh7HT9dV9oSOZieAhEjJZUHaAA9VnXELb
   OWS9FdR/PBk0n/R9qqWlI8FO1tKDPQOWydcZww8cP2dUHthKuaOWq5EvC
   TPnsR7So4Myu3P7rsgxVX4GOurd4tNOsvZNP742GdzVKaDXd2QJQYtt5h
   A=;
IronPort-SDR: w6zYCs3swOAc/YkrJJHVivg8zdqPSpCmkcZm2pM51Uc9RrwGGI9XLhGDz4FqVI7EmrrhmQPqvp
 XmeLVfEZVjpw==
X-IronPort-AV: E=Sophos;i="5.68,267,1569283200"; 
   d="scan'208";a="3935220"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Nov 2019 16:21:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 01333A0644;
        Mon,  4 Nov 2019 16:21:47 +0000 (UTC)
Received: from EX13D28UWB001.ant.amazon.com (10.43.161.98) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 4 Nov 2019 16:21:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D28UWB001.ant.amazon.com (10.43.161.98) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 4 Nov 2019 16:21:47 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Mon, 4 Nov 2019 16:21:47 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 7C154C7197; Mon,  4 Nov 2019 16:21:47 +0000 (UTC)
Date:   Mon, 4 Nov 2019 16:21:47 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chucklever@gmail.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
Message-ID: <20191104162147.GA31399@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
 <20191104030132.GD26578@fieldses.org>
 <358420D8-596E-4D3B-A01C-DACB101F0017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <358420D8-596E-4D3B-A01C-DACB101F0017@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:36:03AM -0500, Chuck Lever wrote:
> 
> Following the server's local file systems' mount options seems like a
> good way to go. In particular, is there a need to expose user xattrs
> on the server host, but prevent NFS clients' access to them? I can't
> think of one.

Ok, that sounds fine to me - I'll remove the user_xattr export flag,
and we had already agreed to do away with the CONFIGs.

That leaves one last item with regard to enabling support: the client side
mount option. I assume the [no]user_xattr option should work the same as
with other filesystems. What about the default setting?

Also, currently, my code does not fail the mount operation if user xattrs
are asked for, but the server does not support them. It just doesn't
set NFS_CAP_XATTR for the server, and the xattr handler entry points
eturn -EOPNOTSUPP, as they check for NFS_CAP_XATTR. What's the preferred
behavior there?

- Frank
