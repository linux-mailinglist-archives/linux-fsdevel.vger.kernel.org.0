Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB61599BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgBKT1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgBKT1C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:27:02 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5674C20873;
        Tue, 11 Feb 2020 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581449222;
        bh=d9iTIU7z0h/UAxXemQIRG88N34pgT887tmSXs635Ibg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQY4MmpobVgaVaTP6qsCiIjySAMLzVQE3jZ/E5xMAk1pJ+Ut1QYPMb+tUrg73yxuB
         GP57yThJgV+rPR8Mpxl7iG7GB/bm5HksdTaptyuDfR1AydFmBQs8QgO6uEqvLly+VS
         W21zUBINJu/dqV0oI3gZqdmbZnG0pVVHo4lh7JYk=
Date:   Tue, 11 Feb 2020 11:27:01 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.or,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 01/18] staging: exfat: Rename function "ffsUmountVol" to
 "ffs_umount_vol"
Message-ID: <20200211192701.GA1971434@kroah.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
 <20200211123859.10429-2-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211123859.10429-2-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:08:42PM +0530, Pragat Pandya wrote:
> Fix checkpatch warning: Avoid CamelCase
> Change all occurrences of function "ffsUmountVol" to "ffs_umount_vol"
> in the source.

I've said this before about this type of change, but there's no need for
the "ffs" prefix at all for almost all of these functions.  Can you just
name them sanely instead?

thanks,

greg k-h
