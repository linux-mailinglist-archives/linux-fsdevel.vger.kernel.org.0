Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E059F7DA45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfHAL1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 07:27:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:54120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfHAL1i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:27:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F8B4AF8A;
        Thu,  1 Aug 2019 11:27:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31557DA7D9; Thu,  1 Aug 2019 13:28:11 +0200 (CEST)
Date:   Thu, 1 Aug 2019 13:28:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        arnd@arndb.de, y2038@lists.linaro.org,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/20] fs: affs: Initialize filesystem timestamp ranges
Message-ID: <20190801112810.GR28208@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        arnd@arndb.de, y2038@lists.linaro.org,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-14-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-14-deepa.kernel@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:17PM -0700, Deepa Dinamani wrote:
> Fill in the appropriate limits to avoid inconsistencies
> in the vfs cached inode times when timestamps are
> outside the permitted range.
> 
> Also fix timestamp calculation to avoid overflow
> while converting from days to seconds.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: dsterba@suse.com

Acked-by: David Sterba <dsterba@suse.com>
