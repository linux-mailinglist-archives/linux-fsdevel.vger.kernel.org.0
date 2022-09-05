Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F35ACBE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiIEHAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 03:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiIEG77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:59:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FF18E32;
        Sun,  4 Sep 2022 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662361181;
        bh=VDRF/oaTASDk9IDkqKtnGDlfc5NOCX8vH8c/Dy9loPE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=g4KxePK1AtoCTVzKnKvbna82hSWNkaOnpqEWhzmeTEFWP3jbn87IFze6maaS+166b
         8I0q7w9Ee0AmRIbmt67QHeUZvrl7+vlkXUkc8x18dWb/RfA0PPWjMvHQQNHK6EWm/z
         TTeNpbCuKjosnYaUlL/VMDyCXtRwhBpiZxbUlGWw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKYx-1oo7pj1khr-00Lm1C; Mon, 05
 Sep 2022 08:59:41 +0200
Message-ID: <227328cc-a41c-be15-ab9f-fa81419b7348@gmx.com>
Date:   Mon, 5 Sep 2022 14:59:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-5-hch@lst.de>
 <ffd39ae8-a7fb-1a75-a2d5-b601cb802b9c@gmx.com> <20220905064816.GD2092@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 04/17] btrfs: handle checksum validation and repair at the
 storage layer
In-Reply-To: <20220905064816.GD2092@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RlQ1tG66gwg8/Xq7xghhG8ELu8vmwyN91uDGkeWIxNtctQIQqzq
 dIkkIDkFjgy3NY2kjDrqx1nc/XnHEXCHRM51XHoeKjdCVL4KR+KVhriPk/BnPxTmznpeFe7
 HLMOpgLXVpvBgzk65+95vlGMjMW4RVWqWKF1yu44iSzf+I9MX8KTELjkmKpt8kcymf+7GA1
 hLtCLWLTAVjV1P9EtOI2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQM6IgIe+bg=:k/BGvkgvvWspmCO1ieIbiR
 vyGufKrpZ7wkQWCtDP5PgQLyyBdgR/KO0CrdA+De17G8+L9PbLD2wrUAqnNcJW5YV4vSGg5UO
 NaxjSYP8Ap3U1v2KkNa6inxBiPjaIorIZD1+hHcI2P/whP6AkiNGUEO7cP65P1sk/fLyYZt2O
 CWU9fprt20PgeWEvYdoRm/SgREmQCmeh0KCC9Ovgt5jUbBgtVkLBL+lLa/RQUFR+JPfylN1qV
 PxfEpHBverSWnfPuOfXsbGz28630BnjwhX9AQ2wrptWCt05rz9GceR1XRfcibigWTEL8wr2IR
 T4YjZJ8CmE/F0Z6SWzBA/gjirRw7BrYMK+fdzasg2gMSA0GbDEqMoNl2VJBSNnWJBSI9WitUW
 UK9nejJnUzSVT9/ecPeOfo1KXQUXSVrp2f+glH0g+IWI7/q2ogOjX/RsavtJlTNnoaJXKhciK
 UrDHXKu6aGuhSQVVHDw/5AxJ/lCyvPMAlicfC/KlOnZTHGoQI6ural5j9UEgX3taRw9T5SCt3
 K90NSzoDLX4+N2qAkq91gjQVPUAOaHvtXWt4WqkLsNwb4+SdhcdIsnQNoSU6Hvj6J1jLBWdf+
 8scX0AHXg7UaX0p8/vU+gmbjnSPX2WxbIEZ+NeqQgxDW4C//4sUjYrVXDQVm+3DwlqddOUtD3
 vYLZkLj2YrLGN+Th6Jv3gNZWDIAaq05VXLrWMe1GhsU5YGi2ENi2F0eOkTDtta9/PTR4fR6hS
 oglgGuCephcx5TJIwKZt+0dALBv7oV26rMfHLsnEY26P4+mF7IDFspKx20E4pxx4n/Jtld7qR
 mVOIswg3/lyVDRIo+/0/+ZQ0fXL0pZComg/EKnugoAT0YG5QWae8XzCKkOa8UD0oATlFN6Ujh
 xPnxbp0kbBbnX375mZVlx3gEO0gU5J5TIuMWayP1JxzuRaghbV1k+MAVXH3ArV8PSSC22ummj
 KjN0ixlQlYA63vbSW27dnkL7+D65QVP6ppUaV3MR0mBQsZ6lNY9lhWuJj78hNA38jgQ8sX1rR
 KIBA0i3eLOzWWABRWdrpgq506BXaKh4MtduriQCzKqsbYXXxel2/jAeV/yFT0kKpTgw/ianPf
 8riSFF5MVkKpANizJUOrnPIFv9YPRHfV0FEbqomeF/8BW1CfZ2yHdz/GCo+sVJuj3dpiW3dRP
 zyyAaYWsSZXjfsR4CkLgkG9be4
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/5 14:48, Christoph Hellwig wrote:
> On Thu, Sep 01, 2022 at 05:04:34PM +0800, Qu Wenruo wrote:
>> But for the verification part, I still don't like the idea of putting
>> the verification code at endio context at all.
>
> Why?

Mostly due to the fact that metadata and data go split ways for
verification.

All the verification for data happens at endio time.

While part of the verification of metadata (bytenr, csum, level,
tree-checker) goes at endio, but transid, checks against parent are all
done at btrfs_read_extent_buffer() time.

This also means, the read-repair happens at different timing.

>
>> This is especially true when data and metadata are still doing differen=
t
>> checksum verfication at different timing.
>
> Note that this does not handle the metadata checksum verification at
> all.  Both because it actually works very different and I could not
> verify that we'd actually always read all data that needs to be verified
> together for metadata, but also because there is zero metadata repair
> coverage in xfstests, so I don't dare to touch that code.
>
>> Can we just let the endio function to do the IO, and let the reader to
>> do the verification after all needed data is read out?
>
> What would the benefit be?  It will lead to a lot of duplicate (and thus
> inconsistent) code that is removed here, and make splitting the bios
> under btrfs_submit_bio much more complicated and expensive.

You're right, my initial suggestion is not good at all.


But what about putting all the needed metadata info (first key, level,
transid etc) also into bbio (using a union to take the same space of
data csum), so that all verification and read repair can happen at endio
time, the same timing as data?

Although this may need to force submitting metadata for every tree
block, I guess it's more or less feasible, since metadata read is more
like a random read, other than sequential read.

By this we can also eliminate the duplicated read-repair between meta
and data.

Thanks,
Qu
