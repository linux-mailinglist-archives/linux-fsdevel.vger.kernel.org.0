Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6E5B11DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIHBLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiIHBK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:10:59 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2409F77F;
        Wed,  7 Sep 2022 18:10:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EF1F95801B3;
        Wed,  7 Sep 2022 21:10:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 07 Sep 2022 21:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662599441; x=1662606641; bh=Q9
        hIHxnztdrv2DGM0OCPF0EfEIaLl1Vb4zaFETp2jBc=; b=loAkZvnd5HfKJq6/AA
        GuBtz9kINMyRm1mBTpBpF3tOQ4hh9lLscYbv1235Np1SpXXKRjqvfLLwiy97xYuR
        4BsHMrnJq6PMSncX4l63CNvXwhceC69UKdTFNsGmfVIn0To+xYedDSwd/dmH3FEG
        jmAZucJiJt5QnPAiEr+oErEVEWiS5OgkayL73ZYl7Wyhp8SB3TTW+Jak8kO7H6+D
        DMCUPVTlEGxRqE6eTEXFazoVMXdeSSpsNOgZJNKEPeusK+t72wBfBth06fcbVjSX
        E7qiUEgk9pKxXXUZQeFp67BwOrk4F+hmJ6bQXtloMTIkWkJ4m/A7rOSZwVwTnckr
        NoGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662599441; x=1662606641; bh=Q9hIHxnztdrv2DGM0OCPF0EfEIaL
        l1Vb4zaFETp2jBc=; b=zDv52f77k8N+7UfTUeedQOTyTkKg7Yd3L/FPIfaqPKrQ
        cV1i5GZRJ026Z2njd33uwUnlIbcK+d6EmDfUCTP/7yzEOh1IUPYZKTh4xpbGgVnW
        bI/YAO/buxDkKd3FuBrFrGmF4U/38W0b/KvrVABNwpXanYN7d3KBe+VVROgJatvb
        bhwbfqqIG2VtVgN3e7hghMbgRpUqpy134BI3cEcNkHkuwBJMaQaf46Iwgu1eVqF4
        hSZiJCIMiiMXc9tlBqx4AsKX5javeSb5us011DZcOmav15CpjEPq9fmY+UM694Fz
        UGNXmHvoQv4gjV/iz//iHXuFHhmpopXb5ISCIWd+qw==
X-ME-Sender: <xms:D0EZY191ykx22sa3eH6qYCga0lxMQJuj16B97IRTtlyzqOgdn-U-MA>
    <xme:D0EZY5tvMXWyIIzPaoFzF1_XFJ6i4D5Ke9B9EYbY9rKdVJmWzrYtAyFpEqB8nWXnW
    C0wH7pgtn-zmlRsoBk>
X-ME-Received: <xmr:D0EZYzAflpQ9SHYHbRne24v4IUMRUm0l2mnZeupWr0HuSs36CF0gdwkRdDFCKNyGB7AD2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:D0EZY5fTE8lZVpB7V8xTRuN8Ys7_xwAKjzJV8d0CEn1C_SfgPr_o6w>
    <xmx:D0EZY6OFAqs8Xf4YzDaIR_Lpdx0acaKLM5XXiDeyHQ11yzbGPfMoCA>
    <xmx:D0EZY7n0TSGGg_ECIC9-h3n7rnPgvQHsohEwhsGCBZg20lXZt7KBVg>
    <xmx:EUEZY97fbsA5PmNBNpF2CPdmBJoUhmNwBcRhKo7kY6f0hGwIF7LvDw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 21:10:39 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 199AE103799; Thu,  8 Sep 2022 04:10:37 +0300 (+03)
Date:   Thu, 8 Sep 2022 04:10:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220908011037.ez2cdorthqxkerwk@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
 <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:24:39PM +0300, Kirill A . Shutemov wrote:
> On Sat, Aug 20, 2022 at 10:15:32PM -0700, Hugh Dickins wrote:
> > > I will try next week to rework it as shim to top of shmem. Does it work
> > > for you?
> > 
> > Yes, please do, thanks.  It's a compromise between us: the initial TDX
> > case has no justification to use shmem at all, but doing it that way
> > will help you with some of the infrastructure, and will probably be
> > easiest for KVM to extend to other more relaxed fd cases later.
> 
> Okay, below is my take on the shim approach.
> 
> I don't hate how it turned out. It is easier to understand without
> callback exchange thing.
> 
> The only caveat is I had to introduce external lock to protect against
> race between lookup and truncate. Otherwise, looks pretty reasonable to me.
> 
> I did very limited testing. And it lacks integration with KVM, but API
> changed not substantially, any it should be easy to adopt.
> 
> Any comments?

Updated version below. Nothing major. Some simplification and cleanups.

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 4f1600413f91..334ddff08377 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -3,6 +3,7 @@
 #define __LINUX_MEMFD_H
 
 #include <linux/file.h>
+#include <linux/pfn_t.h>
 
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
@@ -13,4 +14,27 @@ static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
 }
 #endif
 
+struct inaccessible_notifier;
+
+struct inaccessible_notifier_ops {
+	void (*invalidate)(struct inaccessible_notifier *notifier,
+			   pgoff_t start, pgoff_t end);
+};
+
+struct inaccessible_notifier {
+	struct list_head list;
+	const struct inaccessible_notifier_ops *ops;
+};
+
+void inaccessible_register_notifier(struct file *file,
+				    struct inaccessible_notifier *notifier);
+void inaccessible_unregister_notifier(struct file *file,
+				      struct inaccessible_notifier *notifier);
+
+int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
+			 int *order);
+void inaccessible_put_pfn(struct file *file, pfn_t pfn);
+
+struct file *memfd_mkinaccessible(struct file *memfd);
+
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..9d066be3d7e8 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -101,5 +101,6 @@
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
+#define INACCESSIBLE_MAGIC	0x494e4143	/* "INAC" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..48750474b904 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,7 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_INACCESSIBLE	0x0008U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/Makefile b/mm/Makefile
index 9a564f836403..f82e5d4b4388 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
 obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
-obj-$(CONFIG_MEMFD_CREATE) += memfd.o
+obj-$(CONFIG_MEMFD_CREATE) += memfd.o memfd_inaccessible.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..1853a90f49ff 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -261,7 +261,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+		       MFD_INACCESSIBLE)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -283,6 +284,14 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
+	/* Disallow sealing when MFD_INACCESSIBLE is set. */
+	if ((flags & MFD_INACCESSIBLE) && (flags & MFD_ALLOW_SEALING))
+		return -EINVAL;
+
+	/* TODO: add hugetlb support */
+	if ((flags & MFD_INACCESSIBLE) && (flags & MFD_HUGETLB))
+		return -EINVAL;
+
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
 	if (len <= 0)
@@ -331,10 +340,24 @@ SYSCALL_DEFINE2(memfd_create,
 		*file_seals &= ~F_SEAL_SEAL;
 	}
 
+	if (flags & MFD_INACCESSIBLE) {
+		struct file *inaccessible_file;
+
+		inaccessible_file = memfd_mkinaccessible(file);
+		if (IS_ERR(inaccessible_file)) {
+			error = PTR_ERR(inaccessible_file);
+			goto err_file;
+		}
+
+		file = inaccessible_file;
+	}
+
 	fd_install(fd, file);
 	kfree(name);
 	return fd;
 
+err_file:
+	fput(file);
 err_fd:
 	put_unused_fd(fd);
 err_name:
diff --git a/mm/memfd_inaccessible.c b/mm/memfd_inaccessible.c
new file mode 100644
index 000000000000..dc79988a49d0
--- /dev/null
+++ b/mm/memfd_inaccessible.c
@@ -0,0 +1,219 @@
+#include "linux/sbitmap.h"
+#include <linux/memfd.h>
+#include <linux/pagemap.h>
+#include <linux/pseudo_fs.h>
+#include <linux/shmem_fs.h>
+#include <uapi/linux/falloc.h>
+#include <uapi/linux/magic.h>
+
+struct inaccessible_data {
+	struct mutex lock;
+	struct file *memfd;
+	struct list_head notifiers;
+};
+
+static void inaccessible_notifier_invalidate(struct inaccessible_data *data,
+				 pgoff_t start, pgoff_t end)
+{
+	struct inaccessible_notifier *notifier;
+
+	mutex_lock(&data->lock);
+	list_for_each_entry(notifier, &data->notifiers, list) {
+		notifier->ops->invalidate(notifier, start, end);
+	}
+	mutex_unlock(&data->lock);
+}
+
+static int inaccessible_release(struct inode *inode, struct file *file)
+{
+	struct inaccessible_data *data = inode->i_mapping->private_data;
+
+	fput(data->memfd);
+	kfree(data);
+	return 0;
+}
+
+static long inaccessible_fallocate(struct file *file, int mode,
+				   loff_t offset, loff_t len)
+{
+	struct inaccessible_data *data = file->f_mapping->private_data;
+	struct file *memfd = data->memfd;
+	int ret;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
+			return -EINVAL;
+		}
+	}
+
+	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
+	inaccessible_notifier_invalidate(data, offset, offset + len);
+	return ret;
+}
+
+static const struct file_operations inaccessible_fops = {
+	.release = inaccessible_release,
+	.fallocate = inaccessible_fallocate,
+};
+
+static int inaccessible_getattr(struct user_namespace *mnt_userns,
+				const struct path *path, struct kstat *stat,
+				u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct inaccessible_data *data = inode->i_mapping->private_data;
+	struct file *memfd = data->memfd;
+
+	return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,
+					     request_mask, query_flags);
+}
+
+static int inaccessible_setattr(struct user_namespace *mnt_userns,
+				struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct inaccessible_data *data = inode->i_mapping->private_data;
+	struct file *memfd = data->memfd;
+	int ret;
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		if (memfd->f_inode->i_size)
+			return -EPERM;
+
+		if (!PAGE_ALIGNED(attr->ia_size))
+			return -EINVAL;
+	}
+
+	ret = memfd->f_inode->i_op->setattr(mnt_userns,
+					    file_dentry(memfd), attr);
+	return ret;
+}
+
+static const struct inode_operations inaccessible_iops = {
+	.getattr = inaccessible_getattr,
+	.setattr = inaccessible_setattr,
+};
+
+static int inaccessible_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, INACCESSIBLE_MAGIC))
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	return 0;
+}
+
+static struct file_system_type inaccessible_fs = {
+	.owner		= THIS_MODULE,
+	.name		= "[inaccessible]",
+	.init_fs_context = inaccessible_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static struct vfsmount *inaccessible_mnt;
+
+static __init int inaccessible_init(void)
+{
+	inaccessible_mnt = kern_mount(&inaccessible_fs);
+	if (IS_ERR(inaccessible_mnt))
+		return PTR_ERR(inaccessible_mnt);
+	return 0;
+}
+fs_initcall(inaccessible_init);
+
+struct file *memfd_mkinaccessible(struct file *memfd)
+{
+	struct inaccessible_data *data;
+	struct address_space *mapping;
+	struct inode *inode;
+	struct file *file;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->memfd = memfd;
+	mutex_init(&data->lock);
+	INIT_LIST_HEAD(&data->notifiers);
+
+	inode = alloc_anon_inode(inaccessible_mnt->mnt_sb);
+	if (IS_ERR(inode)) {
+		kfree(data);
+		return ERR_CAST(inode);
+	}
+
+	inode->i_mode |= S_IFREG;
+	inode->i_op = &inaccessible_iops;
+	inode->i_mapping->private_data = data;
+
+	file = alloc_file_pseudo(inode, inaccessible_mnt,
+				 "[memfd:inaccessible]", O_RDWR,
+				 &inaccessible_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		kfree(data);
+	}
+
+	file->f_flags |= O_LARGEFILE;
+
+	mapping = memfd->f_mapping;
+	mapping_set_unevictable(mapping);
+	mapping_set_gfp_mask(mapping,
+			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
+
+	return file;
+}
+
+void inaccessible_register_notifier(struct file *file,
+				    struct inaccessible_notifier *notifier)
+{
+	struct inaccessible_data *data = file->f_mapping->private_data;
+
+	mutex_lock(&data->lock);
+	list_add(&notifier->list, &data->notifiers);
+	mutex_unlock(&data->lock);
+}
+EXPORT_SYMBOL_GPL(inaccessible_register_notifier);
+
+void inaccessible_unregister_notifier(struct file *file,
+				      struct inaccessible_notifier *notifier)
+{
+	struct inaccessible_data *data = file->f_mapping->private_data;
+
+	mutex_lock(&data->lock);
+	list_del(&notifier->list);
+	mutex_unlock(&data->lock);
+}
+EXPORT_SYMBOL_GPL(inaccessible_unregister_notifier);
+
+int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
+			 int *order)
+{
+	struct inaccessible_data *data = file->f_mapping->private_data;
+	struct file *memfd = data->memfd;
+	struct page *page;
+	int ret;
+
+	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
+	if (ret)
+		return ret;
+
+	*pfn = page_to_pfn_t(page);
+	*order = thp_order(compound_head(page));
+	SetPageUptodate(page);
+	unlock_page(page);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
+
+void inaccessible_put_pfn(struct file *file, pfn_t pfn)
+{
+	struct page *page = pfn_t_to_page(pfn);
+
+	if (WARN_ON_ONCE(!page))
+		return;
+
+	put_page(page);
+}
+EXPORT_SYMBOL_GPL(inaccessible_put_pfn);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
