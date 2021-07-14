Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32C3C7E18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 07:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhGNFvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 01:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbhGNFvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:51:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923FFC0613E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 22:48:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ec55so1524962edb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISPhdRd7kgRF131of+I49P7OQzeT4zgllEAZ6yc66Cw=;
        b=CRCCf/8GTFicMvq9b/39MqKOLA4VR5W/ygtwaJLI0t2FCj5mbGw+0F5fvOpYhQBlrp
         mnWkMFmm1NRwvDJrruNdW/yFacogODt3bCpAldP7YRcTEBrB9r1iBC2NjEl0kUTRdDqQ
         1LDJkNtefZh3Inp027Damv068boUObxXQE1Pm1ikQNRrKOn0QiMcT+UqofXREN+wn0AY
         Qwlp4lF5HnpBmLE3ay7KGuePAPoflcJyMWHPJ6Bnc8lPzXEAzgnhzHTc+Z5cugll/6CO
         prP+98aaVF7nhR72k5BdnaouBNhEtSUaq/qfnkjt1V52oVKY2JDemFXyTzCt7m8WNALL
         Fl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISPhdRd7kgRF131of+I49P7OQzeT4zgllEAZ6yc66Cw=;
        b=cy7xW6nkvuS12/Qgyzdse8DAaZUv/ozlI45+DVbBpdBDy0UFjYBCTIYaPfzz14Q8an
         DIt7JQmHNIgtC4BQZ03Or4FQ89gyEd+ij/OvlKVB2k091QnjHcAtEwJ98qtEGi/lKmap
         yxxDSHJaTqQDa7gp3257ZDy1T/Gh5xMpjxKSYCNjBMSCZjrusRWosEz/Erbye1Ua1hej
         irag9SFQGKfm+e971nQYJATTAxWaaYL1sw5TWYZeLLHpnTPTd0nz0wuohXDgVQlaJ0Hj
         ziy9ij7e6zqQAeDphbdQxZ4KZvXkQ5gx7vcU+/YGpvdSj+G/NTLJ0kYDFB6RQ5MdsaRn
         7msQ==
X-Gm-Message-State: AOAM531cTLWSvSPenJh2ydsQ0k1FtRWq/X5SB+sDlW+e5/a26B7XRRwT
        WdaGkDBfRZMc2dnc4A7HZ2iBFcaKnFRQ+0opNM85
X-Google-Smtp-Source: ABdhPJxXeEP7t8zpZ7c72shHdFobOH14/MjRGIjC6cNWOwN1I+LFplaCEgLfUWMkJbOdheWG/GEx1jYGgqe4NN7VDzo=
X-Received: by 2002:a50:ff01:: with SMTP id a1mr10892387edu.253.1626241703073;
 Tue, 13 Jul 2021 22:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210713084656.232-1-xieyongji@bytedance.com> <20210713084656.232-4-xieyongji@bytedance.com>
 <8aa028a0117ecb51d209861f926a84ce74fe0c46.camel@perches.com>
In-Reply-To: <8aa028a0117ecb51d209861f926a84ce74fe0c46.camel@perches.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 14 Jul 2021 13:48:12 +0800
Message-ID: <CACycT3t99LoN86KH2Hz38ZnqdgsV4tt4UGNB4QqOvX40Xji5vA@mail.gmail.com>
Subject: Re: [PATCH v9 03/17] vdpa: Fix code indentation
To:     Joe Perches <joe@perches.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        Greg KH <gregkh@linuxfoundation.org>,
        He Zhe <zhe.he@windriver.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 12:20 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-07-13 at 16:46 +0800, Xie Yongji wrote:
> > Use tabs to indent the code instead of spaces.
>
> There are a lot more of these in this file.
>
> $ ./scripts/checkpatch.pl --fix-inplace --strict include/linux/vdpa.h
>
> and a little typing gives:
> ---
>  include/linux/vdpa.h | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 3357ac98878d4..14cd4248e59fd 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
>   * @last_used_idx: used index
>   */
>  struct vdpa_vq_state_packed {
> -        u16    last_avail_counter:1;
> -        u16    last_avail_idx:15;
> -        u16    last_used_counter:1;
> -        u16    last_used_idx:15;
> +       u16     last_avail_counter:1;
> +       u16     last_avail_idx:15;
> +       u16     last_used_counter:1;
> +       u16     last_used_idx:15;
>  };
>
>  struct vdpa_vq_state {
> -     union {
> -          struct vdpa_vq_state_split split;
> -          struct vdpa_vq_state_packed packed;
> -     };
> +       union {
> +               struct vdpa_vq_state_split split;
> +               struct vdpa_vq_state_packed packed;
> +       };
>  };
>
>  struct vdpa_mgmt_dev;
> @@ -131,7 +131,7 @@ struct vdpa_iova_range {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             @state: pointer to returned state (last_avail_idx)
> - * @get_vq_notification:       Get the notification area for a virtqueue
> + * @get_vq_notification:       Get the notification area for a virtqueue
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the notifcation area
> @@ -277,13 +277,13 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>                                         const struct vdpa_config_ops *config,
>                                         size_t size, const char *name);
>
> -#define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
> -                         container_of(__vdpa_alloc_device( \
> -                                      parent, config, \
> -                                      sizeof(dev_struct) + \
> -                                      BUILD_BUG_ON_ZERO(offsetof( \
> -                                      dev_struct, member)), name), \
> -                                      dev_struct, member)
> +#define vdpa_alloc_device(dev_struct, member, parent, config, name)    \
> +       container_of(__vdpa_alloc_device(parent, config,                \
> +                                        sizeof(dev_struct) +           \
> +                                        BUILD_BUG_ON_ZERO(offsetof(dev_struct, \
> +                                                                   member)), \
> +                                        name),                         \
> +                    dev_struct, member)
>
>  int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
>  void vdpa_unregister_device(struct vdpa_device *vdev);
> @@ -308,8 +308,8 @@ struct vdpa_driver {
>  int __vdpa_register_driver(struct vdpa_driver *drv, struct module *owner);
>  void vdpa_unregister_driver(struct vdpa_driver *drv);
>
> -#define module_vdpa_driver(__vdpa_driver) \
> -       module_driver(__vdpa_driver, vdpa_register_driver,      \
> +#define module_vdpa_driver(__vdpa_driver)                              \
> +       module_driver(__vdpa_driver, vdpa_register_driver,              \
>                       vdpa_unregister_driver)
>
>  static inline struct vdpa_driver *drv_to_vdpa(struct device_driver *driver)
> @@ -339,25 +339,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>
>  static inline void vdpa_reset(struct vdpa_device *vdev)
>  {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +       const struct vdpa_config_ops *ops = vdev->config;
>
>         vdev->features_valid = false;
> -        ops->set_status(vdev, 0);
> +       ops->set_status(vdev, 0);
>  }
>
>  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +       const struct vdpa_config_ops *ops = vdev->config;
>
>         vdev->features_valid = true;
> -        return ops->set_features(vdev, features);
> +       return ops->set_features(vdev, features);
>  }
>
> -
> -static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
> +static inline void vdpa_get_config(struct vdpa_device *vdev,
> +                                  unsigned int offset,
>                                    void *buf, unsigned int len)
>  {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +       const struct vdpa_config_ops *ops = vdev->config;
>
>         /*
>          * Config accesses aren't supposed to trigger before features are set.
>
>

Oh, yes. I miss that. Thanks for the reminder!

Will fix it in the next version.

Thanks,
Yongji
