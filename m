Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F628E3E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgJNQBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:01:48 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com ([98.137.65.82]:36466
        "EHLO sonic313-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbgJNQBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602691307; bh=/sK8vKP+HgENJ2KbRKwaakALG1IJ7NVFbxhkXwQJZJ8=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=IGmrltnFkLJW4X3YjPlHdbMMSg3inRjB+IVV0cntt57Z3SF5t38Hz+pWqEUDjkio0/nBDPxWGlvrNUsZ6b7I7ToCTgdaNLIXe3uS/LmnXgIHFypH2p5uKig7OoGO+N01YJQfzkydaCJGNX8UmMtqW1VH+chGBGo/RP+Ny0fH3zndFDvRGMIcdbeCXZRzqG+wOG/02Z0xIij3Pfs7ovkQblF4vZzRZ+jckpLJKFqw14FxZLkXPwpH1Mnke3w8MGKraLAuop0INJyBJ7Av/FPi/KF23VOl0TXtQe8dy4qNg/j/S+TENEaPRObTapcWZ0eRYwR9n2Arkweu8Z955PoCNQ==
X-YMail-OSG: FpHCXvYVM1lCRnikmgMsWcgjZPs9SMDHhpdzsqUOtxcVVgBddGNuM20bH2_RzJ_
 zvsQvmdmdkGjkCtJkZB062qix1bGPhS1IofA1HCMuK3dSDvI2zUy18jmEhKCtASIa_zpHSQIBZyi
 saWvBmxa7AS_u8PKI2vV6dNA0hz2mH2_3QEXOCcbyzTMzxnk90YzqxgQfuWbUDwLfmjuIaqLYb.T
 T1LmegNPXzBf0X0TubQ0Xn_0OzzOduzSB8tlg0NU5sT5WPBWuxdJBYu8oGn03nFSNWp.alEcA6jc
 44bhxZh8Kh7wvn.529TidX2vlIUdBinyAW3zOvZeOd4dZJDOI0Gpdi.t_O.didYsI_oe9krLL__T
 PRld8IYLRyBWrT86iNjWEjJLG1N01Xq6MnzOtYte7QQGn8Toqc1fzJFEi4vca2SF9ES6aaAfAO5_
 Re1Uihac3I5ow4RE7vGO3vsWnhbEq5wWo7aC6eO9s_mcmKxtboBmM_9BQSMBjibDxG4Xcfqux2bR
 3EReT6U7HRQTWbPpE3YJiJ8gBHQ8kV.TwEQ8bVcixfA0T7qxBQN2qZ83BPdDcde9OYhak6R60osT
 dNViZeICIulCUrwXJQmTx.2oxegAaPibq8pUJznE7IfeMQqKuD0QACdysGxnsi7UoN7n.Aw1Gw0N
 JhsElAGpurYLtSDe8gAAm9ih2p11UJcOQsX0auPvq5xUPioPeO1WLe0RfknMbI7Z5ShEe14p6hQt
 u1AM1eQ1dyO4zjLHAWAAaIlZncO6pjiGqomXQp2DyWKn_AOV6MCatLFiZL4BjhiO8e_26JZ9orEF
 UVhhTnPM5A1xq6FoS.Q1JhXW1WeLxhMK9RJVj49f2lGClnTRexBdlNTUCd9wtIzYI0J9NsKBbpIz
 1lR4YUDp_vqDHCjTS3gxllGlJa1VRlvriCaqtff7q3If8XYMNHsL_8fm1ciy274JTGqtJW4oKyHP
 6RgX1s_8Ssi_EpP4bfY_3gVY4kVMVrZ8LvPnVR901PAk94BLjrq6bksd4isX_XEJAA0crFaRrYCT
 qhu7wplM3VkXeKSSUU8inGnZdODquMUJNxzolILXo8gezMPbeRDsSxuYqbsPUrFWXLgMdRgBKM1Z
 eC7FVndIeZ8EyPTzFa.61hQyBE5eNVcGcO37nC3ynJVKuhwq2TjDWw4cyC3lFia8bcEUAjdT6Xhd
 O3n.SLw.T3UN87sBURqtGWK8ZbbMUZZ8_gaNHM6NtMe9gdtKvLn3GQ1tzL_v1JA1RQkz7U0Vv0X7
 3VrBDE83eo30ACvL4TZEOEEjkpoL30IJci566qxqKO3iOz5MjV3tuW2z7tVfLiMbnsUb15fcE_Jl
 .OItq1nQHCJIinG.xdplg1nyKRb512ijD0WFmkbT3zlGP7m51WlDO1NyEB7SQefg30oTH.jJCWQX
 MHBUwiLRCjPoixSP.TdAvHQ6XumDSG3wdMUeRdVB8MHPOZlsJnVVpr_kjTLxcZv3d6VdQEFbkPx.
 LAPHHnKMYHowU4681K9iRVl7aIyzVlUwevWhByPeJi5NG1n89QTwVB21psaUY6m6mt1d75ARJGo_
 SRQdEuJjG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Wed, 14 Oct 2020 16:01:47 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 951cb00b4ca334412a3e8773b5eee046;
          Wed, 14 Oct 2020 16:01:40 +0000 (UTC)
Date:   Thu, 15 Oct 2020 00:01:30 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: PagePrivate handling
Message-ID: <20201014160116.GA7037@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201014134909.GL20115@casper.infradead.org>
 <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
 <20201014153836.GM20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8\""
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201014153836.GM20115@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16845 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol Apache-HttpAsyncClient/4.1.4 (Java/15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:38:36PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 14, 2020 at 10:50:51AM -0400, Chris Mason wrote:
> > On 14 Oct 2020, at 9:49, Matthew Wilcox wrote:

...

> > > 
> > > Also ... do we really need to increment the page refcount if we have
> > > PagePrivate set?  I'm not awfully familiar with the buffercache -- is
> > > it possible we end up in a situation where a buffer, perhaps under I/O,
> > > has the last reference to a struct page?  It seems like that reference
> > > is
> > > always put from drop_buffers() which is called from
> > > try_to_free_buffers()
> > > which is always called by someone who has a reference to a struct page
> > > that they got from the pagecache.  So what is this reference count for?
> > 
> > Iâ€™m not sure what we gain by avoiding the refcount bump?  Many filesystems
> > use the pattern of: â€œput something in page->private, free that thing in
> > releasepage.â€  Without the refcount bump it feels like weâ€™d have more magic
> > to avoid freeing the page without leaking things in page->private.  I think
> > the extra ref lets the FS crowd keep our noses out of the MM more often, so
> > it seems like a net positive to me.
> 
> The question is whether the "thing" in page->private can ever have the
> last reference on a struct page.  Gao says erofs can be in that situation,
> so never mind this change.

Add some words, just my thought... we have a management structure which could
store PagePrivate page cache pages, !PagePrivate page cache pages, and non-page
cache pages which are directly from buddy system.

and I knew the extra refcount rule for PagePrivate from the beginning (since
the rule is quite stable for many many years (I remembered from 200x introduced
by akpm?) so I designed the whole workflow to handle these different types of
pages in the management structure based on this rule and to make reclaim &
migrate work for all page cache pages properly.). I think many modules think
the rule is stable as well ... anyway, I think there's always be another way
to handle the same thing if the refcount rule is changed, yet I need to
revisit all current logic and do proper changes. And I think many modules
(including out-of-tree modules) could be impacted as well... anyway...

Thanks,
Gao Xiang

> 
