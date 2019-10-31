Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8FEB8EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 22:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfJaVXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 17:23:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43116 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726680AbfJaVXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:23:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9VLNDrq015053
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 17:23:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 74851420456; Thu, 31 Oct 2019 17:23:13 -0400 (EDT)
Date:   Thu, 31 Oct 2019 17:23:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191031212313.GH16197@mit.edu>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 09:07:33PM -0400, Valdis Kletnieks wrote:
> Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> (c) if one patch, who gets to shepherd it through?

Acked-by: Theodore Ts'o <tytso@mit.edu>
