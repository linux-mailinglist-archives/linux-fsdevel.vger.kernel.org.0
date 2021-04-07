Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F899356B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbhDGLdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbhDGLdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:33:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805DC061756;
        Wed,  7 Apr 2021 04:33:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b7so27116616ejv.1;
        Wed, 07 Apr 2021 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=igApDUlpCeCEweoCqg22t/B3MoQOPZ9NvMZmM26l5kk=;
        b=o2NFHNvesDb3O8KuZFkQr+4Dnv7siCRgFNdsd/iC5NtpFRMigSBYB6M6QwVpNW5Ooa
         kfum0JtmQKE/rkzfU2BKmHxUcCIlrFSayIvzYmK0QTuqBamEDyjNvBdIQ4qUgDNr8M/B
         Cik0IgB9DOlEel24Sg/jQvamZIXqV+2QnMswfAgR45unpO5/QdNhDspaYXxjEM6ekcbA
         z48SEDh5VDpW35uZB4RQhcnu9GjF8JT15lhyqbpUJk2YrDmp1JEKwSkJrtaoUz9kanaj
         0nhdTqFmWcP/3OWBECj1WR/KtIqQwj0hK47IfaKKumELK2N04wpC0odg4zidoIHegvCg
         Fhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=igApDUlpCeCEweoCqg22t/B3MoQOPZ9NvMZmM26l5kk=;
        b=prjtgEX5xikkLS2QlP6htKIbXsA/0LBoYHvn9w7zSxo1Jb1Tq87k1Shb1DH/0NRkYs
         Tzmt9giYbngV9dXAOBlM+dfRvsAIwMeMTTnGxMezpp7oYBGEBBJCKqIAzE/ZwMkRcZxN
         BGygQh1caXwovaNHsQRLTKU8XjUxmEipdMtf8DhU8j9GI6HDSCX/s5YDcmTDlxxbX9J+
         g2SGtjaskVsNtXQYEd81QtD/IUrQ6/IX/DPq7mFjQ2lJywp4H/F6OpU6ahmBXn7njoVI
         2de3QDQi0bq4A3iWTybE9PH1dBnnMCqMZpnU9o/IlTanOsM6HBGvsYRaI1472jiaulbP
         cxXA==
X-Gm-Message-State: AOAM530H4agRkFrfg+coUBWDtqE6NzJgGlXKfGOWWhBU1w81IpjOI/J0
        jHegQ2uPgL2nZ8cm8ebtb0qxjFQjkPWjkKRMBGQ=
X-Google-Smtp-Source: ABdhPJzc/YwNumqv2Y9xVfgysBRWlCYkcsd5UT93ZQ8MucuaZJeEd1d9j3pK91td8dANc0HUggHjMUzh+6Z+kkv+nsg=
X-Received: by 2002:a17:906:f953:: with SMTP id ld19mr3083534ejb.164.1617795180009;
 Wed, 07 Apr 2021 04:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com> <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Selva Jove <selvajove@gmail.com>
Date:   Wed, 7 Apr 2021 17:02:48 +0530
Message-ID: <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Initially I started moving the dm-kcopyd interface to the block layer
as a generic interface.
Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is
tightly coupled with dm_io()

To move dm-kcopyd to block layer, it would also require dm_io code to
be moved to block layer.
It would cause havoc in dm layer, as it is the backbone of the
dm-layer and needs complete
rewriting of dm-layer. Do you see any other way of doing this without
having to move dm_io code
or to have redundant code ?


On Sat, Feb 20, 2021 at 10:29 AM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:
>
> On 2021/02/20 11:01, SelvaKumar S wrote:
> > Add new BLKCOPY ioctl that offloads copying of one or more sources
> > ranges to a destination in the device. Accepts a 'copy_range' structure
> > that contains destination (in sectors), no of sources and pointer to th=
e
> > array of source ranges. Each source range is represented by 'range_entr=
y'
> > that contains start and length of source ranges (in sectors).
> >
> > Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> > bio with control information as payload and submit to the device.
> > REQ_OP_COPY(19) is a write op and takes zone_write_lock when submitted
> > to zoned device.
> >
> > If the device doesn't support copy or copy offload is disabled, then
> > copy operation is emulated by default. However, the copy-emulation is a=
n
> > opt-in feature. Caller can choose not to use the copy-emulation by
> > specifying a flag 'BLKDEV_COPY_NOEMULATION'.
> >
> > Copy-emulation is implemented by allocating memory of total copy size.
> > The source ranges are read into memory by chaining bio for each source
> > ranges and submitting them async and the last bio waits for completion.
> > After data is read, it is written to the destination.
> >
> > bio_map_kern() is used to allocate bio and add pages of copy buffer to
> > bio. As bio->bi_private and bio->bi_end_io are needed for chaining the
> > bio and gets over-written, invalidate_kernel_vmap_range() for read is
> > called in the caller.
> >
> > Introduce queue limits for simple copy and other helper functions.
> > Add device limits as sysfs entries.
> >       - copy_offload
> >       - max_copy_sectors
> >       - max_copy_ranges_sectors
> >       - max_copy_nr_ranges
> >
> > copy_offload(=3D 0) is disabled by default. This needs to be enabled if
> > copy-offload needs to be used.
> > max_copy_sectors =3D 0 indicates the device doesn't support native copy=
.
> >
> > Native copy offload is not supported for stacked devices and is done vi=
a
> > copy emulation.
> >
> > Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> > Signed-off-by: Chaitanya Kulkarni <kch@kernel.org>
> > ---
> >  block/blk-core.c          | 102 ++++++++++++++++--
> >  block/blk-lib.c           | 222 ++++++++++++++++++++++++++++++++++++++
> >  block/blk-merge.c         |   2 +
> >  block/blk-settings.c      |  10 ++
> >  block/blk-sysfs.c         |  47 ++++++++
> >  block/blk-zoned.c         |   1 +
> >  block/bounce.c            |   1 +
> >  block/ioctl.c             |  33 ++++++
> >  include/linux/bio.h       |   1 +
> >  include/linux/blk_types.h |  14 +++
> >  include/linux/blkdev.h    |  15 +++
> >  include/uapi/linux/fs.h   |  13 +++
> >  12 files changed, 453 insertions(+), 8 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 7663a9b94b80..23e646e5ae43 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -720,6 +720,17 @@ static noinline int should_fail_bio(struct bio *bi=
o)
> >  }
> >  ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
> >
> > +static inline int bio_check_copy_eod(struct bio *bio, sector_t start,
> > +             sector_t nr_sectors, sector_t max_sect)
> > +{
> > +     if (nr_sectors && max_sect &&
> > +         (nr_sectors > max_sect || start > max_sect - nr_sectors)) {
> > +             handle_bad_sector(bio, max_sect);
> > +             return -EIO;
> > +     }
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Check whether this bio extends beyond the end of the device or part=
ition.
> >   * This may well happen - the kernel calls bread() without checking th=
e size of
> > @@ -738,6 +749,75 @@ static inline int bio_check_eod(struct bio *bio, s=
ector_t maxsector)
> >       return 0;
> >  }
> >
> > +/*
> > + * Check for copy limits and remap source ranges if needed.
> > + */
> > +static int blk_check_copy(struct bio *bio)
> > +{
> > +     struct blk_copy_payload *payload =3D bio_data(bio);
> > +     struct request_queue *q =3D bio->bi_disk->queue;
> > +     sector_t max_sect, start_sect, copy_size =3D 0;
> > +     sector_t src_max_sect, src_start_sect;
> > +     struct block_device *bd_part;
> > +     int i, ret =3D -EIO;
> > +
> > +     rcu_read_lock();
> > +
> > +     bd_part =3D __disk_get_part(bio->bi_disk, bio->bi_partno);
> > +     if (unlikely(!bd_part)) {
> > +             rcu_read_unlock();
> > +             goto out;
> > +     }
> > +
> > +     max_sect =3D  bdev_nr_sectors(bd_part);
> > +     start_sect =3D bd_part->bd_start_sect;
> > +
> > +     src_max_sect =3D bdev_nr_sectors(payload->src_bdev);
> > +     src_start_sect =3D payload->src_bdev->bd_start_sect;
> > +
> > +     if (unlikely(should_fail_request(bd_part, bio->bi_iter.bi_size)))
> > +             goto out;
> > +
> > +     if (unlikely(bio_check_ro(bio, bd_part)))
> > +             goto out;
>
> There is no rcu_unlock() in that out label. Did you test ?
>
> > +
> > +     rcu_read_unlock();
> > +
> > +     /* cannot handle copy crossing nr_ranges limit */
> > +     if (payload->copy_nr_ranges > q->limits.max_copy_nr_ranges)
> > +             goto out;
> > +
> > +     for (i =3D 0; i < payload->copy_nr_ranges; i++) {
> > +             ret =3D bio_check_copy_eod(bio, payload->range[i].src,
> > +                             payload->range[i].len, src_max_sect);
> > +             if (unlikely(ret))
> > +                     goto out;
> > +
> > +             /* single source range length limit */
> > +             if (payload->range[i].len > q->limits.max_copy_range_sect=
ors)
> > +                     goto out;
>
> ret is not set. You will return success with this.
>
> > +
> > +             payload->range[i].src +=3D src_start_sect;
> > +             copy_size +=3D payload->range[i].len;
> > +     }
> > +
> > +     /* check if copy length crosses eod */
> > +     ret =3D bio_check_copy_eod(bio, bio->bi_iter.bi_sector,
> > +                             copy_size, max_sect);
> > +     if (unlikely(ret))
> > +             goto out;
> > +
> > +     /* cannot handle copy more than copy limits */
> > +     if (copy_size > q->limits.max_copy_sectors)
> > +             goto out;
>
> Again ret is not set... No error return ?
>
> > +
> > +     bio->bi_iter.bi_sector +=3D start_sect;
> > +     bio->bi_partno =3D 0;
> > +     ret =3D 0;
> > +out:
> > +     return ret;
> > +}
> > +
> >  /*
> >   * Remap block n of partition p to block n+start(p) of the disk.
> >   */
> > @@ -827,14 +907,16 @@ static noinline_for_stack bool submit_bio_checks(=
struct bio *bio)
> >       if (should_fail_bio(bio))
> >               goto end_io;
> >
> > -     if (bio->bi_partno) {
> > -             if (unlikely(blk_partition_remap(bio)))
> > -                     goto end_io;
> > -     } else {
> > -             if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
> > -                     goto end_io;
> > -             if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk=
))))
> > -                     goto end_io;
> > +     if (likely(!op_is_copy(bio->bi_opf))) {
> > +             if (bio->bi_partno) {
> > +                     if (unlikely(blk_partition_remap(bio)))
> > +                             goto end_io;
> > +             } else {
> > +                     if (unlikely(bio_check_ro(bio, bio->bi_disk->part=
0)))
> > +                             goto end_io;
> > +                     if (unlikely(bio_check_eod(bio, get_capacity(bio-=
>bi_disk))))
> > +                             goto end_io;
> > +             }
> >       }
> >
> >       /*
> > @@ -858,6 +940,10 @@ static noinline_for_stack bool submit_bio_checks(s=
truct bio *bio)
> >               if (!blk_queue_discard(q))
> >                       goto not_supported;
> >               break;
> > +     case REQ_OP_COPY:
> > +             if (unlikely(blk_check_copy(bio)))
> > +                     goto end_io;
> > +             break;
> >       case REQ_OP_SECURE_ERASE:
> >               if (!blk_queue_secure_erase(q))
> >                       goto not_supported;
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index 752f9c722062..97ba58d8d9a1 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -150,6 +150,228 @@ int blkdev_issue_discard(struct block_device *bde=
v, sector_t sector,
> >  }
> >  EXPORT_SYMBOL(blkdev_issue_discard);
> >
> > +int blk_copy_offload(struct block_device *dest_bdev, struct blk_copy_p=
ayload *payload,
> > +             sector_t dest, gfp_t gfp_mask)
>
> Simple copy is only over the same device, right ? So the name "dest_bdev"=
 is a
> little strange.
>
> > +{
> > +     struct request_queue *q =3D bdev_get_queue(dest_bdev);
> > +     struct bio *bio;
> > +     int ret, payload_size;
> > +
> > +     payload_size =3D struct_size(payload, range, payload->copy_nr_ran=
ges);
> > +     bio =3D bio_map_kern(q, payload, payload_size, gfp_mask);
> > +     if (IS_ERR(bio)) {
> > +             ret =3D PTR_ERR(bio);
> > +             goto err;
>
> This will do a bio_put() on a non existent bio...
>
> > +     }
> > +
> > +     bio->bi_iter.bi_sector =3D dest;
> > +     bio->bi_opf =3D REQ_OP_COPY | REQ_NOMERGE;
> > +     bio_set_dev(bio, dest_bdev);
> > +
> > +     ret =3D submit_bio_wait(bio);
> > +err:
> > +     bio_put(bio);
> > +     return ret;
> > +}
> > +
> > +int blk_read_to_buf(struct block_device *src_bdev, struct blk_copy_pay=
load *payload,
> > +             gfp_t gfp_mask, sector_t copy_size, void **buf_p)
> > +{
> > +     struct request_queue *q =3D bdev_get_queue(src_bdev);
> > +     struct bio *bio, *parent =3D NULL;
> > +     void *buf =3D NULL;
> > +     int copy_len =3D copy_size << SECTOR_SHIFT;
> > +     int i, nr_srcs, ret, cur_size, t_len =3D 0;
> > +     bool is_vmalloc;
> > +
> > +     nr_srcs =3D payload->copy_nr_ranges;
> > +
> > +     buf =3D kvmalloc(copy_len, gfp_mask);
> > +     if (!buf)
> > +             return -ENOMEM;
> > +     is_vmalloc =3D is_vmalloc_addr(buf);
> > +
> > +     for (i =3D 0; i < nr_srcs; i++) {
> > +             cur_size =3D payload->range[i].len << SECTOR_SHIFT;
> > +
> > +             bio =3D bio_map_kern(q, buf + t_len, cur_size, gfp_mask);
> > +             if (IS_ERR(bio)) {
> > +                     ret =3D PTR_ERR(bio);
> > +                     goto out;
> > +             }
> > +
> > +             bio->bi_iter.bi_sector =3D payload->range[i].src;
> > +             bio->bi_opf =3D REQ_OP_READ;
> > +             bio_set_dev(bio, src_bdev);
> > +             bio->bi_end_io =3D NULL;
> > +             bio->bi_private =3D NULL;
> > +
> > +             if (parent) {
> > +                     bio_chain(parent, bio);
> > +                     submit_bio(parent);
> > +             }
> > +
> > +             parent =3D bio;
> > +             t_len +=3D cur_size;
> > +     }
> > +
> > +     ret =3D submit_bio_wait(bio);
> > +     bio_put(bio);
> > +     if (is_vmalloc)
> > +             invalidate_kernel_vmap_range(buf, copy_len);
>
> But blk_write_from_buf() will use the buffer right after this.. Is this r=
eally OK ?
>

As we are over-writing bio->private adn bi->bi_endio during
submit_bio_wait(), the original
bio_map_kern_endio() can't be used to invalidate_kernel_vmap_range().
So we are doing it
here explicitly. invalidate_kernel_vmap_range() is only necessary for
data reads and the buf
is safe to be used in blk_write_from_buf().

>
> > +     if (ret)
> > +             goto out;
> > +
> > +     *buf_p =3D buf;
> > +     return 0;
> > +out:
> > +     kvfree(buf);
> > +     return ret;
> > +}
> > +
> > +int blk_write_from_buf(struct block_device *dest_bdev, void *buf, sect=
or_t dest,
> > +             sector_t copy_size, gfp_t gfp_mask)
> > +{
> > +     struct request_queue *q =3D bdev_get_queue(dest_bdev);
> > +     struct bio *bio;
> > +     int ret, copy_len =3D copy_size << SECTOR_SHIFT;
> > +
> > +     bio =3D bio_map_kern(q, buf, copy_len, gfp_mask);
> > +     if (IS_ERR(bio)) {
> > +             ret =3D PTR_ERR(bio);
> > +             goto out;
> > +     }
> > +     bio_set_dev(bio, dest_bdev);
> > +     bio->bi_opf =3D REQ_OP_WRITE;
> > +     bio->bi_iter.bi_sector =3D dest;
> > +
> > +     bio->bi_end_io =3D NULL;
> > +     ret =3D submit_bio_wait(bio);
> > +     bio_put(bio);
> > +out:
> > +     return ret;
> > +}
> > +
> > +int blk_prepare_payload(struct block_device *src_bdev, int nr_srcs, st=
ruct range_entry *rlist,
> > +             gfp_t gfp_mask, struct blk_copy_payload **payload_p, sect=
or_t *copy_size)
> > +{
> > +
> > +     struct request_queue *q =3D bdev_get_queue(src_bdev);
> > +     struct blk_copy_payload *payload;
> > +     sector_t bs_mask, total_len =3D 0;
> > +     int i, ret, payload_size;
> > +
> > +     if (!q)
> > +             return -ENXIO;
> > +
> > +     if (!nr_srcs)
> > +             return -EINVAL;
> > +
> > +     if (bdev_read_only(src_bdev))
> > +             return -EPERM;
> > +
> > +     bs_mask =3D (bdev_logical_block_size(src_bdev) >> 9) - 1;
> > +
> > +     payload_size =3D struct_size(payload, range, nr_srcs);
> > +     payload =3D kmalloc(payload_size, gfp_mask);
> > +     if (!payload)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < nr_srcs; i++) {
> > +             if (rlist[i].src & bs_mask || rlist[i].len & bs_mask) {
> > +                     ret =3D -EINVAL;
> > +                     goto err;
> > +             }
> > +
> > +             payload->range[i].src =3D rlist[i].src;
> > +             payload->range[i].len =3D rlist[i].len;
> > +
> > +             total_len +=3D rlist[i].len;
> > +     }
> > +
> > +     payload->copy_nr_ranges =3D i;
> > +     payload->src_bdev =3D src_bdev;
> > +     *copy_size =3D total_len;
> > +
> > +     *payload_p =3D payload;
> > +     return 0;
> > +err:
> > +     kfree(payload);
> > +     return ret;
> > +}
> > +
> > +int blk_copy_emulate(struct block_device *src_bdev, struct blk_copy_pa=
yload *payload,
> > +                     struct block_device *dest_bdev, sector_t dest,
> > +                     sector_t copy_size, gfp_t gfp_mask)
> > +{
> > +     void *buf =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D blk_read_to_buf(src_bdev, payload, gfp_mask, copy_size, &=
buf);
> > +     if (ret)
> > +             goto out;
> > +
> > +     ret =3D blk_write_from_buf(dest_bdev, buf, dest, copy_size, gfp_m=
ask);
> > +     if (buf)
> > +             kvfree(buf);
> > +out:
> > +     return ret;
> > +}
>
> I already commented that this should better use the dm-kcopyd design, whi=
ch
> would be far more efficient than this. This will be slow...
>
> Your function blkdev_issue_copy() below should deal only with issuing sim=
ple
> copy (amd later scsi xcopy) for devices that support it. Bring the dm-kco=
pyd
> interface in the block layer as a generic interface for hadling emulation=
.
> Otherwise you are repeating what dm does, but not as efficiently.
>
> > +
> > +/**
> > + * blkdev_issue_copy - queue a copy
> > + * @src_bdev:        source block device
> > + * @nr_srcs: number of source ranges to copy
> > + * @rlist:   array of source ranges in sector
> > + * @dest_bdev:       destination block device
> > + * @dest:    destination in sector
> > + * @gfp_mask:   memory allocation flags (for bio_alloc)
> > + * @flags:   BLKDEV_COPY_* flags to control behaviour
> > + *
> > + * Description:
> > + *   Copy array of source ranges from source block device to
> > + *   destination block devcie. All source must belong to same bdev and
> > + *   length of a source range cannot be zero.
> > + */
> > +
> > +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> > +             struct range_entry *src_rlist, struct block_device *dest_=
bdev,
> > +             sector_t dest, gfp_t gfp_mask, int flags)
> > +{
> > +     struct request_queue *q =3D bdev_get_queue(src_bdev);
> > +     struct request_queue *dest_q =3D bdev_get_queue(dest_bdev);
> > +     struct blk_copy_payload *payload;
> > +     sector_t bs_mask, copy_size;
> > +     int ret;
> > +
> > +     ret =3D blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mas=
k,
> > +                     &payload, &copy_size);
> > +     if (ret)
> > +             return ret;
> > +
> > +     bs_mask =3D (bdev_logical_block_size(dest_bdev) >> 9) - 1;
> > +     if (dest & bs_mask) {
> > +             return -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     if (q =3D=3D dest_q && q->limits.copy_offload) {
> > +             ret =3D blk_copy_offload(src_bdev, payload, dest, gfp_mas=
k);
> > +             if (ret)
> > +                     goto out;
> > +     } else if (flags & BLKDEV_COPY_NOEMULATION) {
>
> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why woul=
d that
> user say "Fail on me if the device does not support copy" ??? This is a w=
eird
> interface in my opinion.
>

BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy() ca=
llers
to use their native copying method instead of the emulated copy that I
added. This way we
ensure that dm uses the hw-assisted copy and if that is not present,
it falls back to existing
copy method.

The other users who don't have their native emulation can use this
emulated-copy implementation.

>
> > +             ret =3D -EIO;
> > +             goto out;
> > +     } else
>
> Missing braces. By you do not need all these else after the gotos anyway.
>
> > +             ret =3D blk_copy_emulate(src_bdev, payload, dest_bdev, de=
st,
> > +                             copy_size, gfp_mask);
> > +
> > +out:
> > +     kvfree(payload);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(blkdev_issue_copy);
> > +
> >  /**
> >   * __blkdev_issue_write_same - generate number of bios with same page
> >   * @bdev:    target blockdev
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 808768f6b174..4e04f24e13c1 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -309,6 +309,8 @@ void __blk_queue_split(struct bio **bio, unsigned i=
nt *nr_segs)
> >       struct bio *split =3D NULL;
> >
> >       switch (bio_op(*bio)) {
> > +     case REQ_OP_COPY:
> > +                     break;
>
> Why would this even be called ? Copy BIOs cannot be split, right ?
>
> >       case REQ_OP_DISCARD:
> >       case REQ_OP_SECURE_ERASE:
> >               split =3D blk_bio_discard_split(q, *bio, &q->bio_split, n=
r_segs);
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 43990b1d148b..93c15ba45a69 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -60,6 +60,10 @@ void blk_set_default_limits(struct queue_limits *lim=
)
> >       lim->io_opt =3D 0;
> >       lim->misaligned =3D 0;
> >       lim->zoned =3D BLK_ZONED_NONE;
> > +     lim->copy_offload =3D 0;
> > +     lim->max_copy_sectors =3D 0;
> > +     lim->max_copy_nr_ranges =3D 0;
> > +     lim->max_copy_range_sectors =3D 0;
> >  }
> >  EXPORT_SYMBOL(blk_set_default_limits);
> >
> > @@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struc=
t queue_limits *b,
> >       if (b->chunk_sectors)
> >               t->chunk_sectors =3D gcd(t->chunk_sectors, b->chunk_secto=
rs);
> >
> > +     /* simple copy not supported in stacked devices */
> > +     t->copy_offload =3D 0;
> > +     t->max_copy_sectors =3D 0;
> > +     t->max_copy_range_sectors =3D 0;
> > +     t->max_copy_nr_ranges =3D 0;
>
> You do not need this. Limits not explicitely initialized are 0 already.
> But I do not see why you can't support copy on stacked devices. That shou=
ld be
> feasible taking the min() for each of the above limit.
>

Disabling stacked device support was feedback from v2.

https://patchwork.kernel.org/project/linux-block/patch/20201204094659.12732=
-2-selvakuma.s1@samsung.com/

>
> > +
> >       /* Physical block size a multiple of the logical block size? */
> >       if (t->physical_block_size & (t->logical_block_size - 1)) {
> >               t->physical_block_size =3D t->logical_block_size;
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index b513f1683af0..625a72541263 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -166,6 +166,44 @@ static ssize_t queue_discard_granularity_show(stru=
ct request_queue *q, char *pag
> >       return queue_var_show(q->limits.discard_granularity, page);
> >  }
> >
> > +static ssize_t queue_copy_offload_show(struct request_queue *q, char *=
page)
> > +{
> > +     return queue_var_show(q->limits.copy_offload, page);
> > +}
> > +
> > +static ssize_t queue_copy_offload_store(struct request_queue *q,
> > +                                    const char *page, size_t count)
> > +{
> > +     unsigned long copy_offload;
> > +     ssize_t ret =3D queue_var_store(&copy_offload, page, count);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (copy_offload && q->limits.max_copy_sectors =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     q->limits.copy_offload =3D copy_offload;
> > +     return ret;
> > +}
>
> This is weird. If you want to allow a user to disable copy offload, then =
use
> max_copy_sectors. This one should be read-only and only indicate if the d=
evice
> supports it or not. I also would actually change this one into
> max_copy_hw_sectors, immutable, indicating the max copy sectors that the =
device
> supports, and 0 for no support. That would allow an easy implementation o=
f
> max_copy_sectors being red/write for controlling enable/disable.
>
> > +
> > +static ssize_t queue_max_copy_sectors_show(struct request_queue *q, ch=
ar *page)
> > +{
> > +     return queue_var_show(q->limits.max_copy_sectors, page);
> > +}
> > +
> > +static ssize_t queue_max_copy_range_sectors_show(struct request_queue =
*q,
> > +             char *page)
> > +{
> > +     return queue_var_show(q->limits.max_copy_range_sectors, page);
> > +}
> > +
> > +static ssize_t queue_max_copy_nr_ranges_show(struct request_queue *q,
> > +             char *page)
> > +{
> > +     return queue_var_show(q->limits.max_copy_nr_ranges, page);
> > +}
> > +
> >  static ssize_t queue_discard_max_hw_show(struct request_queue *q, char=
 *page)
> >  {
> >
> > @@ -591,6 +629,11 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
> >  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
> >  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
> >
> > +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> > +QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");
> > +QUEUE_RO_ENTRY(queue_max_copy_range_sectors, "max_copy_range_sectors")=
;
> > +QUEUE_RO_ENTRY(queue_max_copy_nr_ranges, "max_copy_nr_ranges");
> > +
> >  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
> >  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
> >  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> > @@ -636,6 +679,10 @@ static struct attribute *queue_attrs[] =3D {
> >       &queue_discard_max_entry.attr,
> >       &queue_discard_max_hw_entry.attr,
> >       &queue_discard_zeroes_data_entry.attr,
> > +     &queue_copy_offload_entry.attr,
> > +     &queue_max_copy_sectors_entry.attr,
> > +     &queue_max_copy_range_sectors_entry.attr,
> > +     &queue_max_copy_nr_ranges_entry.attr,
> >       &queue_write_same_max_entry.attr,
> >       &queue_write_zeroes_max_entry.attr,
> >       &queue_zone_append_max_entry.attr,
> > diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> > index 7a68b6e4300c..02069178d51e 100644
> > --- a/block/blk-zoned.c
> > +++ b/block/blk-zoned.c
> > @@ -75,6 +75,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq=
)
> >       case REQ_OP_WRITE_ZEROES:
> >       case REQ_OP_WRITE_SAME:
> >       case REQ_OP_WRITE:
> > +     case REQ_OP_COPY:
> >               return blk_rq_zone_is_seq(rq);
> >       default:
> >               return false;
> > diff --git a/block/bounce.c b/block/bounce.c
> > index d3f51acd6e3b..5e052afe8691 100644
> > --- a/block/bounce.c
> > +++ b/block/bounce.c
> > @@ -254,6 +254,7 @@ static struct bio *bounce_clone_bio(struct bio *bio=
_src, gfp_t gfp_mask,
> >       bio->bi_iter.bi_size    =3D bio_src->bi_iter.bi_size;
> >
> >       switch (bio_op(bio)) {
> > +     case REQ_OP_COPY:
> >       case REQ_OP_DISCARD:
> >       case REQ_OP_SECURE_ERASE:
> >       case REQ_OP_WRITE_ZEROES:
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index d61d652078f4..0e52181657a4 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -133,6 +133,37 @@ static int blk_ioctl_discard(struct block_device *=
bdev, fmode_t mode,
> >                                   GFP_KERNEL, flags);
> >  }
> >
> > +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> > +             unsigned long arg, unsigned long flags)
> > +{
> > +     struct copy_range crange;
> > +     struct range_entry *rlist;
> > +     int ret;
> > +
> > +     if (!(mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> > +             return -EFAULT;
> > +
> > +     rlist =3D kmalloc_array(crange.nr_range, sizeof(*rlist),
> > +                     GFP_KERNEL);
> > +     if (!rlist)
> > +             return -ENOMEM;
> > +
> > +     if (copy_from_user(rlist, (void __user *)crange.range_list,
> > +                             sizeof(*rlist) * crange.nr_range)) {
> > +             ret =3D -EFAULT;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, cra=
nge.dest,
> > +                     GFP_KERNEL, flags);
> > +out:
> > +     kfree(rlist);
> > +     return ret;
> > +}
> > +
> >  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
> >               unsigned long arg)
> >  {
> > @@ -458,6 +489,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,
> >       case BLKSECDISCARD:
> >               return blk_ioctl_discard(bdev, mode, arg,
> >                               BLKDEV_DISCARD_SECURE);
> > +     case BLKCOPY:
> > +             return blk_ioctl_copy(bdev, mode, arg, 0);
> >       case BLKZEROOUT:
> >               return blk_ioctl_zeroout(bdev, mode, arg);
> >       case BLKREPORTZONE:
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 1edda614f7ce..164313bdfb35 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -71,6 +71,7 @@ static inline bool bio_has_data(struct bio *bio)
> >  static inline bool bio_no_advance_iter(const struct bio *bio)
> >  {
> >       return bio_op(bio) =3D=3D REQ_OP_DISCARD ||
> > +            bio_op(bio) =3D=3D REQ_OP_COPY ||
> >              bio_op(bio) =3D=3D REQ_OP_SECURE_ERASE ||
> >              bio_op(bio) =3D=3D REQ_OP_WRITE_SAME ||
> >              bio_op(bio) =3D=3D REQ_OP_WRITE_ZEROES;
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 866f74261b3b..5a35c02ac0a8 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -380,6 +380,8 @@ enum req_opf {
> >       REQ_OP_ZONE_RESET       =3D 15,
> >       /* reset all the zone present on the device */
> >       REQ_OP_ZONE_RESET_ALL   =3D 17,
> > +     /* copy ranges within device */
> > +     REQ_OP_COPY             =3D 19,
> >
> >       /* SCSI passthrough using struct scsi_request */
> >       REQ_OP_SCSI_IN          =3D 32,
> > @@ -506,6 +508,11 @@ static inline bool op_is_discard(unsigned int op)
> >       return (op & REQ_OP_MASK) =3D=3D REQ_OP_DISCARD;
> >  }
> >
> > +static inline bool op_is_copy(unsigned int op)
> > +{
> > +     return (op & REQ_OP_MASK) =3D=3D REQ_OP_COPY;
> > +}
> > +
> >  /*
> >   * Check if a bio or request operation is a zone management operation,=
 with
> >   * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a specia=
l case
> > @@ -565,4 +572,11 @@ struct blk_rq_stat {
> >       u64 batch;
> >  };
> >
> > +struct blk_copy_payload {
> > +     sector_t        dest;
> > +     int             copy_nr_ranges;
> > +     struct block_device *src_bdev;
> > +     struct  range_entry     range[];
> > +};
> > +
> >  #endif /* __LINUX_BLK_TYPES_H */
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 699ace6b25ff..2bb4513d4bb8 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -337,10 +337,14 @@ struct queue_limits {
> >       unsigned int            max_zone_append_sectors;
> >       unsigned int            discard_granularity;
> >       unsigned int            discard_alignment;
> > +     unsigned int            copy_offload;
> > +     unsigned int            max_copy_sectors;
> >
> >       unsigned short          max_segments;
> >       unsigned short          max_integrity_segments;
> >       unsigned short          max_discard_segments;
> > +     unsigned short          max_copy_range_sectors;
> > +     unsigned short          max_copy_nr_ranges;
> >
> >       unsigned char           misaligned;
> >       unsigned char           discard_misaligned;
> > @@ -621,6 +625,7 @@ struct request_queue {
> >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27  /* record rq->alloc_time_ns */
> >  #define QUEUE_FLAG_HCTX_ACTIVE       28      /* at least one blk-mq hc=
tx is active */
> >  #define QUEUE_FLAG_NOWAIT       29   /* device supports NOWAIT */
> > +#define QUEUE_FLAG_SIMPLE_COPY       30      /* supports simple copy *=
/
> >
> >  #define QUEUE_FLAG_MQ_DEFAULT        ((1 << QUEUE_FLAG_IO_STAT) |     =
       \
> >                                (1 << QUEUE_FLAG_SAME_COMP) |          \
> > @@ -643,6 +648,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag,=
 struct request_queue *q);
> >  #define blk_queue_io_stat(q) test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_=
flags)
> >  #define blk_queue_add_random(q)      test_bit(QUEUE_FLAG_ADD_RANDOM, &=
(q)->queue_flags)
> >  #define blk_queue_discard(q) test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_=
flags)
> > +#define blk_queue_copy(q)    test_bit(QUEUE_FLAG_SIMPLE_COPY, &(q)->qu=
eue_flags)
> >  #define blk_queue_zone_resetall(q)   \
> >       test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
> >  #define blk_queue_secure_erase(q) \
> > @@ -1069,6 +1075,9 @@ static inline unsigned int blk_queue_get_max_sect=
ors(struct request_queue *q,
> >               return min(q->limits.max_discard_sectors,
> >                          UINT_MAX >> SECTOR_SHIFT);
> >
> > +     if (unlikely(op =3D=3D REQ_OP_COPY))
> > +             return q->limits.max_copy_sectors;
> > +
>
> I would agreee with this if a copy BIO was always a single range, but tha=
t is
> not the case. So I am not sure this makes sense at all.
>
> >       if (unlikely(op =3D=3D REQ_OP_WRITE_SAME))
> >               return q->limits.max_write_same_sectors;
> >
> > @@ -1343,6 +1352,12 @@ extern int __blkdev_issue_discard(struct block_d=
evice *bdev, sector_t sector,
> >               sector_t nr_sects, gfp_t gfp_mask, int flags,
> >               struct bio **biop);
> >
> > +#define BLKDEV_COPY_NOEMULATION      (1 << 0)        /* do not emulate=
 if copy offload not supported */
> > +
> > +extern int blkdev_issue_copy(struct block_device *src_bdev, int nr_src=
s,
> > +             struct range_entry *src_rlist, struct block_device *dest_=
bdev,
> > +             sector_t dest, gfp_t gfp_mask, int flags);
>
> No need for extern.
>
> > +
> >  #define BLKDEV_ZERO_NOUNMAP  (1 << 0)  /* do not free blocks */
> >  #define BLKDEV_ZERO_NOFALLBACK       (1 << 1)  /* don't write explicit=
 zeroes */
> >
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index f44eb0a04afd..5cadb176317a 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -64,6 +64,18 @@ struct fstrim_range {
> >       __u64 minlen;
> >  };
> >
> > +struct range_entry {
> > +     __u64 src;
> > +     __u64 len;
> > +};
> > +
> > +struct copy_range {
> > +     __u64 dest;
> > +     __u64 nr_range;
> > +     __u64 range_list;
> > +     __u64 rsvd;
> > +};
> > +
> >  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl defin=
itions */
> >  #define FILE_DEDUPE_RANGE_SAME               0
> >  #define FILE_DEDUPE_RANGE_DIFFERS    1
> > @@ -184,6 +196,7 @@ struct fsxattr {
> >  #define BLKSECDISCARD _IO(0x12,125)
> >  #define BLKROTATIONAL _IO(0x12,126)
> >  #define BLKZEROOUT _IO(0x12,127)
> > +#define BLKCOPY _IOWR(0x12, 128, struct copy_range)
> >  /*
> >   * A jump here: 130-131 are reserved for zoned block devices
> >   * (see uapi/linux/blkzoned.h)
> >
>
> Please test your code more thoroughly. It is full of problems that you sh=
ould
> have detected with better testing including RO devices, partitions and er=
ror
> path coverage.
>
> --
> Damien Le Moal
> Western Digital Research
