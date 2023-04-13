Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D36E0C45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDMLQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDMLQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:10 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7261A5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:16:06 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230413111600epoutp0465c2e780eb2d5f7041b528ceef326160~VelloF3Vd2712927129epoutp04s
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 11:16:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230413111600epoutp0465c2e780eb2d5f7041b528ceef326160~VelloF3Vd2712927129epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681384560;
        bh=glqAy4lf9MYSJmrJ1JVo6PRBwerdleu811pPQw5fUts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z7htm0RYV4XNcnGNTeqmk2oIjmILAgPjXvL8k8XsXOnZdrWDwTne8ADFQazsqw8Er
         1WNi58zmT5ETsdYDSLNV1tracSB1U/PtRvKVNfXhezZ2V/NeWDdZnvM5sA6cx4MCaO
         gTXgv5lqmbVwFRhO0r5RqSNy7eG5BBgq7/C1un6I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230413111559epcas5p44e3b2edfa28e5aee23828bd90fec750e~VelkxVttL1206612066epcas5p4Z;
        Thu, 13 Apr 2023 11:15:59 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PxxpP3RlSz4x9Px; Thu, 13 Apr
        2023 11:15:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.8C.09540.D64E7346; Thu, 13 Apr 2023 20:15:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230413103704epcas5p4b868a2dd068a55331184448295406dfe~VeDmbfxlQ3038930389epcas5p4c;
        Thu, 13 Apr 2023 10:37:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230413103704epsmtrp157f17057d84c4dd43d1281d70f88e63f~VeDmZGjAs1222712227epsmtrp18;
        Thu, 13 Apr 2023 10:37:04 +0000 (GMT)
X-AuditID: b6c32a4a-70dfa70000002544-19-6437e46d8a7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.B6.08609.05BD7346; Thu, 13 Apr 2023 19:37:04 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230413103658epsmtip18caf75d4eafcf8a906d1cc18f558aa84~VeDgik2G21368713687epsmtip1i;
        Thu, 13 Apr 2023 10:36:58 +0000 (GMT)
Date:   Thu, 13 Apr 2023 16:06:10 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 9/9] null_blk: add support for copy offload
Message-ID: <20230413103610.3calcy37ogf72y6q@green5>
MIME-Version: 1.0
In-Reply-To: <b8eb491b-ecb6-c559-1340-9984897f2aa4@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97u3T7PqFUV/gFNWXxEHtNrCD7GojC03Y2a4LRnZ5rCj18Io
        bdMWcC7LQHQD5CE4XpU55mu8pKMQAxQmDxlCqUyewng5MQNNpSAOCVHX9uLif5/zPef8zis/
        Du5SzHbnRCt1lEYpVfBZKxjXWnds946d9JcJ5kdckKHzDxydOPMMR+WjWSz0sHUOoDzbIo5m
        mu8x0ZKlG0cT1/ehxkfnmGioqQ5DDRdyMFRa3oYh0y+zGGp7YWWhnJYBgBqHd6KGxg4G6q0v
        YqGfr9xno5azyRiqnUwCqPLhDAPdHPZA906nANT9rJ25343s7Qsl9eMWFlmnH2WT3WNVDLLX
        Ekcay1JZZPWl70jTUCKLzEh+ZA84Nc4kZ37vZ5GZNWWArDZ/Qz42biSNk1YsbNWnMXujKKmM
        0nhSykiVLFopl/BDP4p4O0LsJxB6CwOQP99TKY2lJPyQ98O8341W2HfB94yXKuLsUphUq+X7
        Bu3VqOJ0lGeUSquT8Cm1TKEWqX200lhtnFLuo6R0e4QCwS6xPfBITFTWiFL9T+Cx5gfTjERQ
        91Ya4HIgIYK/FabjaWAFx4UwAWisXGLQxhyA5zJOLxuPAcyvX8DSAMeZcvWijNbrAcy+Vcyk
        jUkA/+zsxB3vMoitsKK2yJnAInZC8wuOQ15L+MD+4TtsRzxOmDhw/tYY2+FYQwTDJzabk3n2
        At0/3WTSvBp2FE4yHMwlguD43SngYFdiAyy4/MTZNyRauTD3Yg2D7i4EtpV70LOtgQ/aa9g0
        u8PprO+XOQGW/ljConNPAqgf1APasQ+e6sxyDoATUfD2wgSD1t+AuZ2VGK2vhBlLkxit82Dt
        +Ze8GVYYilk0u8GBhaRlJuFUV+3yhmwANvWNMc+ATfpXhtO/Uo/mPTDVdoKpt8+DEx7w1+cc
        GndAQ71vMWCWATdKrY2VU1qxepeSSvj/4JGqWCNwfhWv92rB3QmbTwvAOKAFQA7OX8t7GiKW
        ufBk0q+PUxpVhCZOQWlbgNh+rGzc3TVSZf9rSl2EUBQgEPn5+YkCdvsJ+et52yUdkS6EXKqj
        YihKTWle5mEcrnsiFmjaoJXFH7QmPc/JHxTKvjiZqe+BeV4+h4+Yy+ehl693XWZ4/I3YQbeE
        JVc5jyjWqqU9Rw38wk0FH7NEFV/xB/Yb5LJ1h7b5N4BDf5nDA4IChzrbP/fUfYJljzA/kHS/
        VpLd02bddoWX8q2GaZx73fvDKm6X2XDswLXF4ysv1KfHLa7PmzZ0VPVjFs3hO2eTUlIHxp9W
        294M/2x0JrjGY+vGUM2WJo4ppUszK+6SW3KJgKuNYxlHC+73Cba0x1vLd/89ulnU8mWzJYi7
        oPh3vrB1tTLmRmVwctHM/Pl815CS20uXS2cLocslSYEfe6rCPJBepVx3PWXV0g+6qIPWgHf4
        DG2UVOiFa7TS/wB9XoEvswQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTaRzGfWem06GKjkXct1SJaWIiRasYdV+zLitGk0mMLh4xRj9gs50A
        QmvTsXiQrMUj7uLVVANSlRXPWI5qQVO2XBYLrYjVgAdUQErxWAQqa7NFgl1aYvTbk+f5Pf/n
        y5/Chb1EHJWp2stqVPJsCSkg7jVK4helen5ULPHo5yLzwyYcHdaP46i06wyJBhpHACrwj+Jo
        +H4fD421unH0uv4XVDt0gYc6GqoxVHPFgKFbpQ4M2Uo+YsgRGiSRwf4coNrORFRT6yJQ298X
        SfTXjX4+sp89giGrLw+gioFhAjk7xajvxB8AucebeatFTFv7esbY00oy1cYuPuPuvkMwba1a
        xmL6k2Qqrx1ibB06kjl1ZGgCONbDY4brnpHM6SoTYCpbcpl/LfGMxTeIpc7YIVilYLMzc1jN
        4uRdgoyHBpW6aOV+n9fG14Fj0nxAUZBeBsuvKvKBgBLSVgDbKyt4+SBqwhfBG+MP8EkdA299
        ecufhLwABps7IhBBz4dl1otY+BBJJ8KWEBW2Z9Ey+KzzZYTHaQcFS277sHAQQ6+BAb+fH9bR
        E8PuS07e5FE/gKc+PwGTwUzoKvIRYY3TK2BxZS8eHsBpMbz5JTIQRSfDnt53ETyWngPPXw/g
        ejDT+F3b+F3b+K19GeAmIGLVnDJdySWpl6rYfTJOruS0qnTZb3uUFhD5AqnUCmpMfpkdYBSw
        A0jhklnRwbXLFcJohfzAQVazJ02jzWY5OxBThOSH6Cf5rjQhnS7fy2axrJrVfE0xKipOh9VL
        F2zdVvdr6aaD5lX93sSEsaPS7gJ19/Ep8/gJ3veh3Qur/os33ylaMW1LI+ybfyCepTnDY8nr
        4rtd0wKdL+o3B0/uDL7ZsfHKOdqDto9s9n8OJCRpR0SWnJSU4uSf+LhrnadgeUzHz4WiQ/es
        ocvqkf7UF1lKGXn4Ur/d/FSQFVeujSo0TOUeLahzBrPT/nGKt3tzBsSEy9fkKJvxSrdlessG
        7+9n3Pq8oRhU9GmsIothjXqUVF2SlzKYqTlao6ha1+QI6JQe82ibOJf8VNe4oXA0DWbE2pxN
        fZ4T5URZzv2TIeFVtz63oee4ydu6k3tp+9A8u8G+1aqYJ5AQXIY8SYprOPn/ylj8s3QDAAA=
X-CMS-MailID: 20230413103704epcas5p4b868a2dd068a55331184448295406dfe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_14869_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411081400epcas5p151186138b36daf361520b08618300502
References: <20230411081041.5328-1-anuj20.g@samsung.com>
        <CGME20230411081400epcas5p151186138b36daf361520b08618300502@epcas5p1.samsung.com>
        <20230411081041.5328-10-anuj20.g@samsung.com>
        <b8eb491b-ecb6-c559-1340-9984897f2aa4@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_14869_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/04/13 06:28AM, Chaitanya Kulkarni wrote:
>On 4/11/23 01:10, Anuj Gupta wrote:
>> From: Nitesh Shetty <nj.shetty@samsung.com>
>>
>> Implementaion is based on existing read and write infrastructure.
>> copy_max_bytes: A new configfs and module parameter is introduced, which
>> can be used to set hardware/driver supported maximum copy limit.
>>
>> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
>> ---
>>   drivers/block/null_blk/main.c     | 101 ++++++++++++++++++++++++++++++
>>   drivers/block/null_blk/null_blk.h |   8 +++
>>   2 files changed, 109 insertions(+)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index bc2c58724df3..e273e18ace74 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -157,6 +157,10 @@ static int g_max_sectors;
>>   module_param_named(max_sectors, g_max_sectors, int, 0444);
>>   MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>>
>> +static int g_copy_max_bytes = COPY_MAX_BYTES;
>
>how about following ? matches nullb_device->copy_max_bytes type ..
>
>-static int g_copy_max_bytes = COPY_MAX_BYTES;
>-module_param_named(copy_max_bytes, g_copy_max_bytes, int, 0444);
>+static unsigned long g_copy_max_bytes = COPY_MAX_BYTES;
>+module_param_named(copy_max_bytes, g_copy_max_bytes, ulong, 0444);
>
>[...]
>

acked

>> @@ -631,6 +637,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>>   			"badblocks,blocking,blocksize,cache_size,"
>>   			"completion_nsec,discard,home_node,hw_queue_depth,"
>>   			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
>> +			"copy_max_bytes,"
>>   			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>>   			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>>   			"zone_capacity,zone_max_active,zone_max_open,"
>
>why not ?
>
>@@ -637,11 +637,12 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
>                         "badblocks,blocking,blocksize,cache_size,"
>                         "completion_nsec,discard,home_node,hw_queue_depth,"
>                         "irqmode,max_sectors,mbps,memory_backed,no_sched,"
>-                       "copy_max_bytes,"
>                         "poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>                         "submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>                         "zone_capacity,zone_max_active,zone_max_open,"
>-                       "zone_nr_conv,zone_offline,zone_readonly,zone_size\n");
>+                       "zone_nr_conv,zone_offline,zone_readonly,zone_size"
>+                       "copy_max_bytes\n");
>  }
>
>[...]
>

acked, one doubt I see checkpatch complains
"WARNING: quoted string split across lines".
Is there any graceful way to avoid this warning ?

>+static inline int nullb_setup_copy_read(struct nullb *nullb,
>+		struct bio *bio)
>+{
>+	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
>+
>+	memcpy(token->subsys, "nullb", 5);
>
>do you really need to use memcpy here ? can token->subsys be a pointer
>and use with assignment token->subsys = nullb ?
>

We do have token->nullb, which stores this device.
Idea behind token->subsys is to differentiate between different types of
copies. Like copy between namespace, across namespace etc.

>+	token->sector_in = bio->bi_iter.bi_sector;
>+	token->nullb = nullb;
>+	token->sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
>+
>+	return 0;
>+}
>+
>
>no point in return 1 , use local bool for fua instead of repeating
>expression and no need to fold line for nullb_setup_copy_read()
>makes is easy to read and removes extra lines and indentation see below :-
>

acked.

>-static inline int nullb_setup_copy_read(struct nullb *nullb,
>-               struct bio *bio)
>+static inline void nullb_setup_copy_read(struct nullb *nullb, struct bio *bio)
>  {
>         struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
>
>-       memcpy(token->subsys, "nullb", 5);
>+       token->subsys = "nullb;

if you meant, token->subsys = "nullb", yeah we can add this in next
version.

>         token->sector_in = bio->bi_iter.bi_sector;
>         token->nullb = nullb;
>         token->sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
>-
>-       return 0;
>  }
>
>  static inline int nullb_setup_copy_write(struct nullb *nullb,
>@@ -1334,20 +1331,21 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>         sector_t sector = blk_rq_pos(rq);
>         struct req_iterator iter;
>         struct bio_vec bvec;
>+       bool fua = rq->cmd_flags & REQ_FUA;
>
>         if (rq->cmd_flags & REQ_COPY) {
>                 if (op_is_write(req_op(rq)))
>-                       return nullb_setup_copy_write(nullb, rq->bio,
>-                                               rq->cmd_flags & REQ_FUA);
>-               return nullb_setup_copy_read(nullb, rq->bio);
>+                       return nullb_setup_copy_write(nullb, rq->bio, fua);
>+
>+               nullb_setup_copy_read(nullb, rq->bio);
>+               return 0;
>         }
>
>         spin_lock_irq(&nullb->lock);
>         rq_for_each_segment(bvec, rq, iter) {
>                 len = bvec.bv_len;
>                 err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>-                                    op_is_write(req_op(rq)), sector,
>-                                    rq->cmd_flags & REQ_FUA);
>+                                    op_is_write(req_op(rq)), sector, fua);
>                 if (err) {
>                         spin_unlock_irq(&nullb->lock);
>                         return err;
>@@ -1368,12 +1366,13 @@ static int null_handle_bio(struct nullb_cmd *cmd)
>         sector_t sector = bio->bi_iter.bi_sector;
>         struct bio_vec bvec;
>         struct bvec_iter iter;
>+       bool fua = bio->bi_opf & REQ_FUA
>
>         if (bio->bi_opf & REQ_COPY) {
>                 if (op_is_write(bio_op(bio)))
>-                       return nullb_setup_copy_write(nullb, bio,
>-                                                       bio->bi_opf & REQ_FUA);
>-               return nullb_setup_copy_read(nullb, bio);
>+                       return nullb_setup_copy_write(nullb, bio, fua);
>+               nullb_setup_copy_read(nullb, bio);
>+               return 0;
>         }
>
>
>
>
>[...]
>

acked

>+struct nullb_copy_token {
>+	char subsys[5];
>+	struct nullb *nullb;
>+	u64 sector_in;
>+	u64 sectors;
>+};
>+
>
>why not use sector_t ?
>
>diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
>index c67c098d92fa..ffa4b6a6d19b 100644
>--- a/drivers/block/null_blk/null_blk.h
>+++ b/drivers/block/null_blk/null_blk.h
>@@ -70,8 +70,8 @@ enum {
>  struct nullb_copy_token {
>         char subsys[5];
>         struct nullb *nullb;
>-       u64 sector_in;
>-       u64 sectors;
>+       sector_t sector_in;
>+       sector_t sectors;
>  };
>
>

acked

-- Thank you,
-- Nitesh Shetty

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_14869_
Content-Type: text/plain; charset="utf-8"


------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_14869_--
