Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0359F114C21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 06:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLFFqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 00:46:00 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23714 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLFFqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575611160; x=1607147160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YlAk+nLt52VMWFh44naTE5KbNgNM7hmzRme167e7v8s=;
  b=KGj2fWPDiJ+MvkKhHqu+QUgWzykPkKLIWjNwtzFxsauqpYc7xOYAEJDA
   LgtBebDSUV1bjCKbVjClpOLjO3fvjDzQc0GSbGfMLXymv09o2qhR8iNU0
   eSEIemiviWgxEV97f6G7mpUKaK0vFT8llAasRVXIzEyBEgC/Hc3q50dYC
   DNITiBdoLgq+7eY5BVMf02N22m5qpwnUckMmrUdiMiqJxbAhs+uM4sSoF
   YZ2JSdVqpkmcrtnNnTqStG0pneS8yNRNKU47Z2Elqi7NbiBoIc5KT5z8n
   AYvfhULP1+4aYVemdeRbPhrigt6aW4Mlf1emP6gcecYvTyJxlPMY5JSdV
   A==;
IronPort-SDR: xCZrPiueKu87lbpp5J2BZHpaa8LlfYnfjSCnoQRRzYxbKkgDkta2UgZZQUuRfwDnJGd8bVT+Jv
 Ve2xULQctaDdb+Tzn/tNOclKPB6yLetulUYfLiPbxEnjuvTvXEFCRNZOXnXB2TjItxsyLHMoF3
 tRYUdlrXFPHa2+WklS6f9C8JcOMD5Q0UZZ4K77XcsUB22Kavd/vHVOL8QxFtIAY0UmQ2pIFaHl
 gNJqMrazn3O8wQJLvEFRTRSKxzDo/laAj46utMFJaRAffzAg33U/hyDzc6QGkOzwi3NTBP9N2d
 FVY=
X-IronPort-AV: E=Sophos;i="5.69,283,1571673600"; 
   d="scan'208";a="126363356"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2019 13:46:00 +0800
IronPort-SDR: RT1rZnna9AZGeNk5ie5HSVORBQD2sQN8jyKMialirbD6Ch11dPJuP6MYdPav3Kvz53FZarzpO4
 W+P7Y1xiQqx5kmB3IxWljSXCLoM3NZgOy2d5XdNu2vU7ujk82lR+sKx74TVzG1NRa+DNkITU+N
 ho+7U1fsZ1Y5y5RcjCj8fvEK0fDfgp5pCTw21f/MKm2jJa68+Wnc5uNHCb0PlfhHXQDirFhYP2
 klTtJt391/CEdhgguJQOVm2IHyX2vDdjorOfJGRM9gHVPID9BjrXzbx6vcBe7ohq8z8VG6tSeO
 x8+eUOD5/dwCT0e7GU+vEWGR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 21:40:22 -0800
IronPort-SDR: rJHO4TqeAMDfoD7SAp3MTjAzippAUDnHqA8B5V+LQNj1MASiri8ZBF2imtCFbF9HOpeg082LDi
 biTMUDD3lwANHd4fn2UslD0PFPB37V6l8oB2fXm755OTeNgIOLFCdgkJw8KpOtoMhL7Y+jNjlO
 X3LxepQgfdNg8y+tcyD1uTq7jcA/GsxhyYgo8M0rJkA9L+hGMFBUNRJ5JveiVt8DXAmL7Mu95k
 AnUKHkKg5xxLhdD8Mx0FgRMj1pe/GqBiQ0oLOIaFzzzC1DcH4coKrfGqyyV/kcuVixaOD0zFdo
 obg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 05 Dec 2019 21:45:58 -0800
Received: (nullmailer pid 3664338 invoked by uid 1000);
        Fri, 06 Dec 2019 05:45:57 -0000
Date:   Fri, 6 Dec 2019 14:45:57 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 09/28] btrfs: align device extent allocation to zone
 boundary
Message-ID: <20191206054557.tdfdfeb2wwisbqoz@naota.dhcp.fujisawa.hgst.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-10-naohiro.aota@wdc.com>
 <20191205085625.GD6051@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191205085625.GD6051@Johanness-MacBook-Pro.local>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:56:25AM +0100, Johannes Thumshirn wrote:
>On Wed, Dec 04, 2019 at 05:17:16PM +0900, Naohiro Aota wrote:
>[...]
>
>Only commenting on the code, not the design, sorry. I'll leave that to someone
>with more experience in BTRFS.
>
>>  	 * at an offset of at least 1MB.
>>  	 */
>>  	search_start = max_t(u64, search_start, SZ_1M);
>> +	/*
>> +	 * For a zoned block device, skip the first zone of the device
>> +	 * entirely.
>> +	 */
>> +	if (device->zone_info)
>> +		zone_size = device->zone_info->zone_size;
>> +	search_start = max_t(u64, search_start, zone_size);
>> +	search_start = btrfs_zone_align(device, search_start);
>
>	if (device->zone_info) {
>		zone_size = device->zone_info->zone_size;
>		search_start = max_t(u64, search_start, zone_size);
>		search_start = btrfs_zone_align(device, search_start);
>	}
>
>That's the equivalent code, but should make it a bit more clear what's
>happening int the HMZONED and !HMZOED cases.
>
>And I /guess/ we're saving some cycles in the !HMZONED case as we don't have
>to adjust search start there.
>
>[...]
>
>> @@ -4778,6 +4805,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	int i;
>>  	int j;
>>  	int index;
>> +	int hmzoned = btrfs_fs_incompat(info, HMZONED);
>
>	bool hmzoned = btrfs_fs_incompat(info, HMZONED);
>

Thanks, followed all the change.

