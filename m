Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39193B7208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 05:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfISDzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 23:55:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40802 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbfISDzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:55:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAnXX-0007X9-Fx; Thu, 19 Sep 2019 03:55:31 +0000
Date:   Thu, 19 Sep 2019 04:55:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, LKP <lkp@01.org>
Subject: Re: 266a9a8b41: WARNING:possible_recursive_locking_detected
Message-ID: <20190919035531.GL1131@ZenIV.linux.org.uk>
References: <20190914161622.GS1131@ZenIV.linux.org.uk>
 <20190916020434.tutzwipgs4f6o3di@inn2.lkp.intel.com>
 <20190916025827.GY1131@ZenIV.linux.org.uk>
 <20190916030355.GZ1131@ZenIV.linux.org.uk>
 <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
 <20190916171606.GA1131@ZenIV.linux.org.uk>
 <bd707e64-9650-e9ed-a820-e2cabd02eaf8@huawei.com>
 <20190917120117.GG1131@ZenIV.linux.org.uk>
 <c79495de-9f51-4e9b-97e1-0f98a147cd8a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c79495de-9f51-4e9b-97e1-0f98a147cd8a@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:36:28AM +0800, zhengbin (A) wrote:

> >> + dput(to);
> >> dput(to) should be in if if (file->f_pos > 2)? cause we dget(to) in scan_positives
> > dput(NULL) is a no-op
> 
> +    spin_unlock(&dentry->d_lock);
> +    dput(*res);
> +    *res = found;
> +    return p;
> 
> dput(*res) should be removed?

Huh?  Why would it?  We drop the original reference and replace it with the
new one; what's the problem?
