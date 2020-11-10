Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0EA2ACFD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 07:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgKJGho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 01:37:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8592 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKJGhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604991419; x=1636527419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fHEI12nauRKrqeL0CzD1Uo2SWafLY6cW1Z+aJTBLznY=;
  b=dnA8ham9jPsAWIcxlNsjv2zV8V05g9yxpn49W00aft/3FV+AqaDpkW91
   O+pstmv+aUZqrNl18RkmJ1AYYs7clFJNs1GQe+iJYcnU7thkT/YW+Of02
   J8rallsWXl5cvIMgadOKz2vL5DHoYsQ2ls7z0gqhfks0mRXbU/NsGp356
   5Ue8JvFPxAIRI+AIcZ7HpA1vbuixAA9pyWvtd/zvH5qqAU3Z6Tg0B9A7v
   EftafupKbQGWxpNl46u9c8ueBnVOV/njuTUfpL/eM5GEYZjdicQWy/Fg+
   aodu3aWvkn1ehAkCIKEJItZjzfIBHV+aOGo1S/WQZ88SMwG+N1hYvndFQ
   A==;
IronPort-SDR: Xud0SSXmQ3dS3ttf3tZJ9gz4MGhNuvuwIezHf/IJYtEO/TRlq8LaKXS5JZKIcaCIuGFQ+I/vat
 OZaqHJqgDryN/0O19Lx9Xd2lI9LaXLVUKnrfjAgGOxH8fvTLo/nQLGLdpoil5y7MVJlsbTU+/b
 9FPyilLij5+crGNsV0ZnJSYq67G9PyqxSZ9y5RVUdYIqZSHgxT4v5kuY85kJq6594NvTPWsbKC
 qkTrTappFe8kI0rJSGbU/H3il6SoLpGuJQQwDrARagJ1r4QwJ7M4J+700EmSNwXRNqCeD9hwFz
 3Gk=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="255811479"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 14:56:59 +0800
IronPort-SDR: v9NspyWyS24Ko7oNCLcsaAN/qGOOgwVr8uI/7dgRbP484mO1btq+xBLBi0EqdsJtq34CKub88H
 ABvefZAkVyBuyc1nI22dNX8ILknwy7fIPNp+28u5g4VFMLJ9blMfFfvZ0tFEQ/1nAhZ4ByrjPI
 9qtkT573nBJG9SvoQX5QYQBG7DXhXOd2XdoOmFPEOouV0wpGLDrKC55+oXjUyX88qeSlPFHRBO
 WGzBsmXNrvDxuslyBDQ/0v2GP3PQ5/1hO3L8HlYwnAwe3ygm0NDExwQX3+U/AxJuYTzLVX/Cz0
 NEo1YzcIDoAmse6I+PN5p4QM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:22:30 -0800
IronPort-SDR: YlThQWu/+X57Eijovqwx+efvDVCUqiA5WYLJTeTQX9H2njcb3Hwm14MS8v8wvAMJjIqeNR2ikV
 JdApWcyX9tdXB5tXFrdOAFcFWDmii0/KaoxCQOpJJ1drkzxzAu79S0T1QQlH5fVApZ+Y0iIMr6
 glY8Cpvw8ZI6ZKjU6iFEcK1qd5muQbcQpteoOIY81JOyBDGesy8k6a9GbGBBg8iZcmDESH5vmh
 pFC155O7O/LMH02TFBxeVQbYwALQyvpXP08jxWvG+O1FWrMyNCDiteqy5l9D4U7kuSUpjrgkb9
 wHg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 09 Nov 2020 22:37:42 -0800
Received: (nullmailer pid 1486946 invoked by uid 1000);
        Tue, 10 Nov 2020 06:37:41 -0000
Date:   Tue, 10 Nov 2020 15:37:41 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v9 38/41] btrfs: extend zoned allocator to use dedicated
 tree-log block group
Message-ID: <20201110063741.reca4c72vglfylvw@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <6640d3c034c9c347958860743501aff59da7a5a0.1604065695.git.naohiro.aota@wdc.com>
 <eb8f83f2-fb59-2b65-66e2-18cd0ecd1e02@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <eb8f83f2-fb59-2b65-66e2-18cd0ecd1e02@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:47:33PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>This is the 1/3 patch to enable tree log on ZONED mode.
>>
>>The tree-log feature does not work on ZONED mode as is. Blocks for a
>>tree-log tree are allocated mixed with other metadata blocks, and btrfs
>>writes and syncs the tree-log blocks to devices at the time of fsync(),
>>which is different timing from a global transaction commit. As a result,
>>both writing tree-log blocks and writing other metadata blocks become
>>non-sequential writes that ZONED mode must avoid.
>>
>>We can introduce a dedicated block group for tree-log blocks so that
>>tree-log blocks and other metadata blocks can be separated write streams.
>>As a result, each write stream can now be written to devices separately.
>>"fs_info->treelog_bg" tracks the dedicated block group and btrfs assign
>>"treelog_bg" on-demand on tree-log block allocation time.
>>
>>This commit extends the zoned block allocator to use the block group.
>>
>>Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>If you're going to remove an entire block group from being allowed to 
>be used for metadata you are going to need to account for it in the 
>space_info, otherwise we're going to end up with nasty ENOSPC corners 
>here.

Indeed. I'll add a dedicated space_info for treelog or, at least, separate
the block group from other metadata space_info. But, I'll address this
later in v11.

>
>But this begs the question, do we want the tree log for zoned?  We 
>could just commit the transaction and call it good enough.  We lose 
>performance, but zoned isn't necessarily about performance.

We have a large performance drop without tree-log (-o notreelog). Here is a
dbench (32 clients) result on SMR HDD.

With treelog:    153.509  MB/s	
Without treelog:  21.9651 MB/s

So, there is 85% drop of the throughput. I think this degradation is too large.

>
>If we do then at a minimum we're going to need to remove this block 
>group from the space info counters for metadata.  Thanks,
>
>Josef
