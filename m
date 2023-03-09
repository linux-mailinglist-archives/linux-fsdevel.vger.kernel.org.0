Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AB06B217B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 11:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCIKcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 05:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCIKcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:32:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A00E501B;
        Thu,  9 Mar 2023 02:32:48 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbp3-1puLvb3lmN-00P7CR; Thu, 09
 Mar 2023 11:32:45 +0100
Message-ID: <62d03fce-0670-8d6a-2ee8-7c8725269fad@gmx.com>
Date:   Thu, 9 Mar 2023 18:32:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-4-hch@lst.de>
 <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com>
 <20230307144106.GA19477@lst.de>
 <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com>
 <5aff53ea-0666-d4d6-3bf1-07b3674a405a@gmx.com>
 <20230308142817.GA14929@lst.de>
 <9c59ce30-f217-568e-a3a0-f5a8fd1ac107@gmx.com>
 <20230309093119.GB23816@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309093119.GB23816@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RRD8NmwZQtpfff9Bh0e4ejy7bLeXP6jjWlhay4ctYig9aFO9SnV
 4CIPfzNPfIiHV/aDti8B19mRe9mvBPDIoYzmOLafjHaXkH0Y56u548p4w6E8DrnotGv+UIB
 yln9gNoRMNW2VNmdHBD2AU0uFuFt1tyCHYpfdnnw0OabmXnNRKtdDQFZ+cWd8olmw1T9O7i
 K+8ODS0SjFKcdz6haFIGg==
UI-OutboundReport: notjunk:1;M01:P0:nkm4I6UXIkU=;W5PwGMz7h+pyuNBX3fp7H5VKXJV
 xKPMTc/+64gPjl801T4z9UfNhsIP87qjqRlLP6DqSJumRPRHuHKRVbC2eVpapZC75G2G5Eno3
 RtJhBE1EEZVJQn2kJ1Me2SHHozb2Aiqu3uocb32uk7Ia4WhFw43nKRWKDuUD/Xv/+xZ5CW2Ad
 47jiCwWG1kTCCTwVCtr5P/9ggWWLd/BUm2ZzPFL+lNBlQ6U6fNLk83kBglQqH7OuT1KHbUTzu
 KpGpymfTxHO3WmYI4I35fE3MlmThEu44Xos2ki3acBeGF5IbCmOfA79ateyP6UEhQ8enQkDSk
 NQ3sFCQ3jowBS1WlpSG9eZW7bqwk9IN4x84SMAXWis4gCSyxKi5lRqnoiVfLuvdCiD88KUic1
 IeA4pVkuURnVokQUQP57ADW7LAamLfcE1BeiM3poXOUTmplQFDche6MJjB2E8FiALYJtKqmdt
 isAaL5r9bLExodDfayFOZqy4nboBJG4Vln6fRGSqiTOHdWUVYk8eKf3iCyc/Zx/DFLom2YmWL
 WcH8tsSRYu2m1s4dlqWbEAoo6XXpu7O2pvbAV/aRHRA7kr5JmeUMjFqTDHL5OA58n0PSPh/oL
 prl8aoSPlQvAZV8LpqLZFSCaS8bXT5aFbL/lrHC034O5yLcCHPTqIziVC/7q8ZvIiRWAwqb5d
 aF+7cPhUTi5ujM1lLJ8lYcC5oF6Eha8xM6WYjoaNdJxhAR9OV24/rzxqbbKITnBq6mvuhpCIR
 YwzfTnr0tn5VGsRfzonsNQFDVn20nIt+EECVmquOQ1HBhgU2ooadzwVxsZefi1HVzNrYWUnMm
 o/7Mc2k91XBk6QCYhAgQWUSJNbyjCe++LdSByx6F26ea1umAOLEqefWlUbElnyAZZ1PW0NsdM
 teO87EjYILsNdovkSI2aGlA4bFdb+CuaIMvisNR8MPb+SufsDgvIVF7sQgH7HKE0Qx8svrCy5
 MxY5dl5NSbVsYrmLwfmKm/rYCSk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/9 17:31, Christoph Hellwig wrote:
> On Thu, Mar 09, 2023 at 08:08:34AM +0800, Qu Wenruo wrote:
>> My current one is a new btrfs_submit_scrub_read() helper, getting rid of
>> features I don't need and slightly modify the endio functions to avoid any
>> checks if no bbio->inode. AKA, most of your idea.
>>
>> So that would be mostly fine.
> 
> This looks mostly ok to me.  I suspect in the longer run all metadata
> I/O might be able to use this helper as well.

IMHO metadata would also go into the btrfs_check_read_bio().

As for now, all the info for metadata verification is already integrated 
into bbio, thus in the long run, the no-check path would be the exception.
> 
>> But for RAID56, the bioc has to live long enough for raid56 work to finish,
>> thus has to go btrfs_raid56_end_io() and rely on the extra bbio->end_io().
> 
> The bioc lifetimes for RAID56 are a bit odd and one of the things I'd
> love to eventually look into, but іt's not very high on the priority list
> right now.

If you have some good ideas, I'm very happy to try.

My current idea is to dump a bioc for btrfs_raid_bio, so 
btrfs_submit_bio() path can just free the bioc after usage, no need to wait.

But not sure if this change would really cleanup the code, thus it would 
still be very low on priority.

Thanks,
Qu
